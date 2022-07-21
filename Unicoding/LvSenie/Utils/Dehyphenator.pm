package LvSenie::Utils::Dehyphenator;
use strict;
use utf8;
use warnings;
use IO::Dir;
use IO::File;

use Exporter();
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(transformFile transformDir);

sub transformFile
{
	autoflush STDOUT 1;
	if (not @_ or @_ < 4 or @_ > 5)
	{
		print <<END;
Script for de-hyphenating a single SENIE file. Output file name is formed as
filename stub + _unhyphened.txt. Source file is expected to be UTF-8 encoded.

Params:
   data directory
   source name stub, e.g. Baum1699_LVV
   source filename, e.g. Baum1699_LVV_Unicode.txt
   encoding, expected cp1257 or UTF-8
   additional file type stub tu add after 'unhyphened', optional

AILab, LUMII, 2020, provided under GPL
END
		exit 1;
	}
	my $dirName = shift @_;
	my $corpusId = shift @_;
	my $fileName = shift @_;
	my $encoding = shift @_;
	my $fileTypeStub = (shift @_ or '');
	$fileName =~ /^(.*?)(\.txt)?$/;
	my $fileNameStub = $1;

	my $in = IO::File->new("$dirName/$fileName", "< :encoding($encoding)")
		or die "Could not open file $dirName/$fileName: $!";
	mkdir "$dirName/res/";
	mkdir "$dirName/res/$corpusId/";
	my $out = IO::File->new("$dirName/res/$corpusId/${fileNameStub}_unhyphened$fileTypeStub.txt", "> :encoding($encoding)")
		or die "Could not open file $dirName/res/$corpusId/${fileNameStub}_unhyphened$fileTypeStub.txt: $!";

	print "Processing $corpusId/$fileNameStub.\n";

	my $prevLine = 0;
	my @emptyLineBuffer = ();
	my $checkBom = 1;
	my $cutFirstFromNextPage = 0;
	while (my $line = <$in>)
	{
		if ($checkBom)
		{
			$line =~ s/^\N{BOM}?(.*)$/$1/;
			$checkBom = 0;
		}

		# Some lines contain fields to be ignored.
		# Author | Book | Chapter | Empty | Page | Source
		if ($line =~
			/^\s*(\@a\{.*\}|\@g\{\w+\}|\@n\{\d+\}|\@x\{\s*\}|\[[\-\w\{\}]+\.lpp\.\]|\@z\{\w+\})\s*$/)
		{
			print $out $line;
		}
		elsif ($line =~ /^\s*$/ and $prevLine =~ /[^\s]-(\{[^}]*\})?(\s*)$/)
		{
			push @emptyLineBuffer, $line;
		}
		else
		{
			# First: process printout previous line, if it has been stored for
			# latter processing.
			if ($prevLine)
			{
				# Chop next line in pieces: leading spaces, ending of the word, correction of the ending, the rest.
				$line =~ /^(\s*)([^\s{]+)(?:{([^}]+)})?(.*\s*)$/; #Funny. Why is the last \s+ needed for correct newline processing?
				my ($spaces, $wordEnd, $corrEnd) = ($1, $2, $3);
				$line = $4;
				# Next line retains original spacing without the first word.
				$line =~ s/^\s*(.*)$/$spaces$1/;
				# Chop the previous line in pieces: the rest, beginning of the word, correction of the beginning, spacing.
				$prevLine =~ /^(.*?)([^\s]*)(?:\{([^}-]*)\})?-(?:\{([^}-]*)-?\})?(\s*)$/;
				my ($wordStart, $corrStart1, $corrStart2, $newline) = ($2, $3, $4, $5);
				my $newPrevLine = $1;
				# Special processing if the $line was @b{smth}
				if ($wordEnd =~ /^\s*\@b$/)
				{
					$cutFirstFromNextPage = 1;
				}
				# Glue together previous line.
				# There is @b and it contains something.
				if ($cutFirstFromNextPage and $corrEnd)
				{
					$corrEnd =~ s/^([^\s]+)(\s.*)?$/$1/;
					# No corrections.
					$newPrevLine = $newPrevLine.$wordStart.$corrEnd;
					# Has corrections.
					$newPrevLine = $newPrevLine.'{'.($corrStart1 or $corrStart2).$corrEnd.'}'
						if ($corrStart1 or $corrStart2);
					# Reappend newline.
					$newPrevLine = $newPrevLine.$newline;
				}
				# There is @b, but contains nothing.
				elsif ($cutFirstFromNextPage)
				{
					# Do nothing.
					$newPrevLine = $prevLine;
				}
				# There is no @b
				else
				{
					# No corrections.
					$newPrevLine = $newPrevLine.$wordStart.$wordEnd;
					# Has corrections
					$newPrevLine = $newPrevLine.'{'.($corrStart1 or $corrStart2 or $wordStart).($corrEnd or $wordEnd).'}'
						if ($corrStart1 or $corrStart2 or $corrEnd);
					# Reappend newline.
					$newPrevLine = $newPrevLine.$newline;
				}


				print $out $newPrevLine;
				print $out join('', @emptyLineBuffer);
				@emptyLineBuffer = ();
				$prevLine = 0;
			}

			# Process previously left $cutFirstFromNextPage
			if ($cutFirstFromNextPage and ($line =~ /^\s*[^\[@\s]/))
			{
				#print $line;
				$cutFirstFromNextPage = 0;
				$line =~ /^\s*[^\s{]+\s*(.*\s*)$/; #Funny. Why is the last \s+ needed for correct newline processing?
				$line = $1 ? $1 :"";
			}

			# Then check, if this line is complete and can be printed out or
			# must be stored for next cycle.
			if ($line =~ /[^\s]-(\{[^}]*\})?\s*$/)
			{
				$prevLine = $line;
			}
			else
			{
				$prevLine = 0;
				print $out $line;
			}
		}

		#print $out $line;
	}
	print $out $prevLine if ($prevLine);

	$in->close();
	$out->close();
}

sub transformDir
{
	autoflush STDOUT 1;
	if (not @_ or @_ < 1 or @_ > 4)
	{
		print <<END;
Script for de-hyphenating SENIE Unicode sources. Source must be provided in
input folder with canonical names and a fixed given infix, e.g.,
Baum1699_LVV.txt or Baum1699_LVV_Unicode.txt. Search infix must contain
everything inbetween canonical name and .txt, except the leading underscore.

Params:
   data directory
   encoding, expected cp1257 or UTF-8
   search infix (optional)
   output infix (optional)

AILab, LUMII, 2018, provided under GPL
END
		exit 1;
	}
	my $dirName = shift @_;
	my $encoding = shift @_;
	my $searchInfix = (shift @_ or '');
	my $outputInfix = (shift @_ or '');
	my $dir = IO::Dir->new($dirName) or die "Folder $dirName is not available: $!";
	$searchInfix = "_$searchInfix" if (length $searchInfix);

	my $baddies = 0;
	my $all = 0;
	while (defined(my $inFile = $dir->read))
	{
		if ((-f "$dirName/$inFile") and $inFile =~ /^(.*?)$searchInfix\.txt$/)
		{
			my $nameStub = $1;
			my $isBad = 0;
			eval
			{
				local $SIG{__WARN__} = sub { $isBad = 1; warn $_[0] }; # This magic makes eval count warnings.
				local $SIG{__DIE__} = sub { $isBad = 1; warn $_[0] }; # This magic makes eval warn on die and count it as problem.
				transformFile($dirName, $nameStub, $inFile, $encoding, $outputInfix);
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