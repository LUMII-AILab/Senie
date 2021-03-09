package LvSenieTranslit::Transliterator;
use strict;
use utf8;
use warnings;

use IO::Dir;
use IO::File;
use LvSenieTranslit::TranslitTables qw(substTable hasTable encodeString decodeString);

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(transformFile transformDir);

# TODO FIXME
# Nu vispār ir baigi nepieklājīgi te tā vienkārši pārkopēt koda gabalu no
# unikoda transliteratora, te būtu jāiet cauri un viss jāpārstrādā tā, lai
# sadarbojas ar vertikālo failu ģeneratoru, bet pieprasījums pēc testa datiem
# ienāca ar pārāk īsu termiņu, viss paliek liels FIXME.

sub transformFile
{
	autoflush STDOUT 1;
	if (not @_ or @_ < 2)
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

AILab, LUMII, 2021, provided under GPL
END
		exit 1;
	}
	my $dirName = shift @_;
	my $fileName = shift @_;
	die "No table found for file $fileName" unless (hasTable($fileName));
	my %table = %{substTable($fileName)};
	my $in = IO::File->new("$dirName/${fileName}_Unicode_unhyphened.txt", "< :encoding(UTF-8)")
		or die "Could not open file $dirName/${fileName}_Unicode_unhyphened.txt: $!";
	mkdir "$dirName/res/";
	mkdir "$dirName/res/${fileName}/";
	my $out = IO::File->new("$dirName/res/${fileName}/${fileName}_Unicode_translitered.txt", "> :encoding(UTF-8)")
		or die "Could not open file $dirName/res/${fileName}/${fileName}_Unicode_translitered.txt: $!";

	while (my $line = <$in>)
	{
		# Some lines contain fields to be ignored.
		unless ($line =~
			/^\s*(\@[abcdefghiklnrsvxz1]\{.*\}|\[[\-\w\{\}]+\.lpp\.\])\s*$/)
		{
			# To avoid replacements in small foreign fragments within the line
			# we encode that text the same way as we encode already substituted
			# text - each character is inclosed in \N{U+E001} and \N{U+E002}.
			$line =~ s/(\@[abcdefghiklnrsvxz1]\{)([^}]*({[^}]*}[^}]*)*)\}/$1${\( &encodeString($2) )}\}/g;
			for my $target (keys %table)
			{
				my $subst = $table{$target};
				# Do not replace in "\@[a-z]{" fragments, and don't replace, what
				# has already been escaped (denoted by \N{U+E001} and \N{U+E002})
				$line =~ s/(?<!\@|\N{U+E001})$target|$target(?!\{|\N{U+E002})/$subst/g;
			}

		}
		# Remove all the \N{U+E001} and \N{U+E002} we used for marking places
		# where to avoid substitutions.
		print $out decodeString($line);
	}

	$in->close();
	$out->close();
}

sub transformDir
{
	autoflush STDOUT 1;
	if (not @_ or @_ != 1)
	{
		print <<END;
Script for transforming SENIE sources to Unicode. Source must be provided in
input folder with canonical names and sufix _Unicode_translitered.txt, e.g.,
Baum1699_LVV_Unicode_translitered.txt.

Params:
   data directory

AILab, LUMII, 2021, provided under GPL
END
		exit 1;
	}
	my $dirName = shift @_;
	my $dir = IO::Dir->new($dirName) or die "Folder $dirName is not available: $!";

	my $baddies = 0;
	my $all = 0;
	while (defined(my $inFile = $dir->read))
	{
		if ((-f "$dirName/$inFile") and $inFile =~ /^(.*?)_Unicode_translitered\.txt$/)
		{
			my $nameStub = $1;
			my $isBad = 0;
			eval
			{
				local $SIG{__WARN__} = sub { $isBad = 1; warn $_[0] }; # This magic makes eval count warnings.
				local $SIG{__DIE__} = sub { $isBad = 1; warn $_[0] }; # This magic makes eval warn on die and count it as problem.
				transformFile($dirName, $nameStub);
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