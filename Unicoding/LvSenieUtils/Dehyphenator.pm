package LvSenieUtils::Dehyphenator;
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
	if (not @_ or @_ != 3)
	{
		print <<END;
Script for de-hyphenating a single SENIE file. Output file name is formed as
filename stub + _unhyphened.txt. Source file is expected to be UTF-8 encoded.

Params:
   data directory
   source name stub, e.g. Baum1699_LVV
   source filename, e.g. Baum1699_LVV_Unicode.txt

AILab, LUMII, 2020, provided under GPL
END
		exit 1;
	}
	my $dirName = shift @_;
	my $corpusId = shift @_;
	my $fileName = shift @_;
	$fileName =~ /^(.*?)(\.txt)?$/;
	my $fileNameStub = $1;

	my $in = IO::File->new("$dirName/$fileName", "< :encoding(UTF-8)")
		or die "Could not open file $dirName/$fileName: $!";
	mkdir "$dirName/res/";
	mkdir "$dirName/res/$corpusId/";
	my $out = IO::File->new("$dirName/res/$corpusId/${fileNameStub}_unhyphened.txt", "> :encoding(UTF-8)")
		or die "Could not open file $dirName/res/$corpusId/${fileNameStub}_unhyphened.txt: $!";

	my $prevLine = 0;
	while (my $line = <$in>)
	{
		# Some lines contain fields to be ignored.
		# Author | Book | Chapter | Empty | Page | Source
		if ($line =~
			/^\s*(\@a\{.*\}|\@g\{\w+\}|\@n\{\d+\}|\@x\{\s*\}|\[[\-\w\{\}]+\.lpp\.\]|\@z\{\w+\})\s*$/)
		{
			print $out $line;
		}
		else
		{
			# First: process printout previous line, if it has been stored for
			# latter processing.
			if ($prevLine)
			{
				$line =~ /^\s*([^\s]+) *(.*\s+)$/; #Funny. Why is the last \s+ needed for correct newline processing?
				my $wordEnd = $1;
				$line = $2;
				$prevLine =~ s/^(.*?)-(\s*)$/$1$wordEnd$2/;
				print $out $prevLine;
				$prevLine = 0;
			}

			# Then check, if this line is complete and can be printed out or
			# must be stored for next cycle.
			if ($line =~ /-\s*$/)
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
	if (not @_ or @_ < 1 or @_ > 2)
	{
		print <<END;
Script for de-hyphenating SENIE Unicode sources. Source must be provided in
input folder with canonical names and a fixed given infix, e.g.,
Baum1699_LVV.txt or Baum1699_LVV_Unicode.txt. Infix must contain everything
inbetween canonical name and .txt, except the leading underscore.

Params:
   data directory
   infix

AILab, LUMII, 2018, provided under GPL
END
		exit 1;
	}
	my $dirName = shift @_;
	my $infix = shift @_;
	my $dir = IO::Dir->new($dirName) or die "Folder $dirName is not available: $!";
	$infix = "_$infix" if (length $infix);

	my $baddies = 0;
	my $all = 0;
	while (defined(my $inFile = $dir->read))
	{
		if ((-f "$dirName/$inFile") and $inFile =~ /^(.*?)$infix\.txt$/)
		{
			my $nameStub = $1;
			my $isBad = 0;
			eval
			{
				local $SIG{__WARN__} = sub { $isBad = 1; warn $_[0] }; # This magic makes eval count warnings.
				local $SIG{__DIE__} = sub { $isBad = 1; warn $_[0] }; # This magic makes eval warn on die and count it as problem.
				transformFile($dirName, $nameStub, $inFile);
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