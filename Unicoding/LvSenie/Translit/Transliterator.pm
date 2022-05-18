package LvSenie::Translit::Transliterator;
use strict;
use utf8;
use warnings;
# This is for unicode printing in comandline, windows enviroments need this.
use open qw( :std :encoding(UTF-8) );

# This should help ensure that strings are unicode-encoded internaly and uses unicode style regexp semantics?
# Unsure.
use Unicode::Semantics qw(up us);
use IO::Dir;
use IO::File;

use LvSenie::Translit::SimpleTranslitTables qw(substTable hasTable printTableErrors);
use LvSenie::Translit::NoreplaceCoding qw(encodeString decodeString smartLowercase ignoreLine $firstSymb $lastSymb);

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(transformFile transformDir transliterateString);

# TODO FIXME
# Nu vispār ir baigi nepieklājīgi te tā vienkārši pārkopēt koda gabalu no
# unikoda transliteratora, te būtu jāiet cauri un viss jāpārstrādā tā, lai
# sadarbojas ar vertikālo failu ģeneratoru, bet pieprasījums pēc testa datiem
# ienāca ar pārāk īsu termiņu, viss paliek liels FIXME.


# If this is nonzero, print debug info un lines matching this string.
our $debugLine = 0;
#our $debug_line = 'ißredſetees war';

sub transformFile
{
	autoflush STDOUT 1;
	if (not @_ or @_ < 2 or @_ > 3)
	{
		print <<END;
Script for transliterating a single SENIE Unicode source. Source file name must
correspond name used in transformation tables + _Unicode_unhyphened.txt Output
file name is formed as filename stub + _Unicode_translitered.txt.

NB! Input files can't use Unicode Private Use Area sumbols U+E001 and U+E002 for
    any meaningful data encoding, those symbols will be lost!

Params:
   data directory
   source filename stub without extension, e.g. Baum1699_LVV
   collection identifier - Apokr1689, JT1685, VD1689_94 - if applicable

AILab, LUMII, 2021, provided under GPL
END
		exit 1;
	}
	my $dirName = shift @_;
	my $fileName = shift @_;
	my $collection = shift @_;

	print "Processing $fileName\n";
	die "No table found for file $fileName" unless (hasTable($fileName, $collection));
	my $table = substTable($fileName, $collection);
	printTableErrors($fileName, $collection);
	my $in = IO::File->new("$dirName/${fileName}_Unicode_unhyphened.txt", "< :encoding(UTF-8)")
		or die "Could not open file $dirName/${fileName}_Unicode_unhyphened.txt: $!";
	mkdir "$dirName/res/";
	mkdir "$dirName/res/${fileName}/";
	my $out = IO::File->new("$dirName/res/${fileName}/${fileName}_Unicode_translitered.txt", "> :encoding(UTF-8)")
		or die "Could not open file $dirName/res/${fileName}/${fileName}_Unicode_translitered.txt: $!";

	while (my $line = up(<$in>))
	{
		$line = &transliterateString($line, $table)
			unless (ignoreLine($line)); # Some lines contain fields to be ignored.

		# Remove all the special simbols we used for marking places
		# where to avoid substitutions.
		print $out $line;
	}

	$in->close();
	$out->close();
}

sub transliterateString
{
	my $line = shift @_;
	my $table = shift @_;
	# To avoid replacements in small foreign fragments within the line
	# we encode them: each character is enclosed in \N{U+E001} and \N{U+E002}.
	$line =~ s/(\@[1abcdefghilnrsvxz]\{)([^}]*({[^}]*}[^}]*)*)\}/$1${\( &encodeString($2) )}\}/g;
	return decodeString(smartLowercase($line)) unless (@$table);

	my $printDebugInfo = ($debugLine and ($line =~ /$debugLine/));
	my $ruleNo = 0;
	if ($printDebugInfo)
	{
		print "$ruleNo: $line";
		print "\n" unless $line =~ /\n$/;
	}
	for my $rule (@$table)
	{
		$ruleNo++;
		my $prevline = $line;
		my ($target, $subst, $iFlag) = @$rule;
		up ($target);
		up ($subst);

		# Do not replace in "\@[a-z]{" fragments, and don't replace, what
		# has already been escaped (denoted by $firstSymb and $lastSymb)
		$iFlag ?
			$line =~ s/(?<!\@|$firstSymb)$target|$target(?!\{|$lastSymb)/$subst/g :
			$line =~ s/(?<!\@|$firstSymb)$target|$target(?!\{|$lastSymb)/$subst/gi;
		if ($printDebugInfo and $prevline ne $line)
		{
			print "$ruleNo: $line";
			print "\n" unless $line =~ /\n$/;
		}
	}
	return decodeString(smartLowercase($line));
}


sub transformDir
{
	autoflush STDOUT 1;
	if (not @_ or @_ < 1 or @_ > 2)
	{
		print <<END;
Script for transforming SENIE sources to Unicode. Source must be provided in
input folder with canonical names and suffix _Unicode_translitered.txt, e.g.,
Baum1699_LVV_Unicode_translitered.txt.

Params:
   data directory
   collection identifier - Apokr1689, JT1685, VD1689_94 - if applicable

AILab, LUMII, 2021, provided under GPL
END
		exit 1;
	}
	my $dirName = shift @_;
	my $collection = shift @_;
	my $dir = IO::Dir->new($dirName) or die "Folder $dirName is not available: $!";

	my $baddies = 0;
	my $all = 0;
	while (defined(my $inFile = $dir->read))
	{
		if ((-f "$dirName/$inFile") and $inFile =~ /^(.*?)_Unicode_unhyphened\.txt$/)
		{
			my $nameStub = $1;
			my $isBad = 0;
			eval
			{
				local $SIG{__WARN__} = sub { $isBad = 1; warn $_[0] }; # This magic makes eval count warnings.
				local $SIG{__DIE__} = sub { $isBad = 1; warn $_[0] }; # This magic makes eval warn on die and count it as problem.
				transformFile($dirName, $nameStub, $collection);
			};
			$baddies = $baddies + $isBad;
			$all++;
		}
	}
	if ($baddies)
	{
		print "Processing $dirName finished, $baddies of $all files failed!";
	}
	else
	{
		print "Processing $dirName ($all files) finished successfully!";
	}
	return $baddies;
}


1;