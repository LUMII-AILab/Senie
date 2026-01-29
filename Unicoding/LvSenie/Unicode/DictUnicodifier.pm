package LvSenie::Unicode::DictUnicodifier;
use strict;
use utf8;
use warnings;
no warnings 'utf8';

use LvSenie::Unicode::Win1257ToUnicodeTables qw(substTable hasTable);
use LvSenie::Unicode::Unicodifier qw(transformLine);
use XML::LibXML;

use Exporter();
use parent qw(Exporter);
our @EXPORT_OK = qw(transformDictionary);

sub transformDictionary
{
    if (not @_ or @_ != 1)
    {
        print <<END;
Script for transforming LVVV XML file to unicode.

Params:
   xml file

AILab, LUMII, 2026, provided under GPL
END
        exit 1;
    }
    my $fileName = shift @_;
    my $dictDom = XML::LibXML->load_xml(location => $fileName);

    # Fix source naming typos
    $dictDom->findnodes('//dtdlist[@name="Source code"]/dtdlistitem[@name="VHL1685_Cat"]/@name')
        ->get_node(1)->setValue("VLH1685_Cat");

    # Convert wordforms using general dictionary table
    my $dictTable = substTable('LVVV_ENTRIES_UNIFIED');
    foreach my $wordformAttr ($dictDom->findnodes('//Dictionary//WordForm/@WordForm'))
    {
        my $transformedLine = transformLine($wordformAttr->nodeValue(), $dictTable);
        $wordformAttr->setValue($transformedLine);
    }

    # Convert examples using source tables
    foreach my $exampleNode ($dictDom->findnodes('//Dictionary//Example | //Dictionary//Citation'))
    {
        my $table = $dictTable;
        my $exampleSourceXmlId = $exampleNode->findnodes('Source/@Source')
            ->get_node(1)->nodeValue();
        if (!$exampleSourceXmlId)
        {
            my $lemmaSign = $exampleNode->findnodes('ancestor::Lemma/@LemmaSign')->get_node(1)->nodeValue();
            warn "Example without source in entry '$lemmaSign'.\n";

        } else
        {
            my $exampleSourceXML = $dictDom->findnodes(
                '//dtdlist[@name="Source code"]/dtdlistitem[@id="'.$exampleSourceXmlId.'"]/@name')
                ->get_node(1)->nodeValue();
            my $exampleSourceBookXML = $exampleNode->findnodes('Source/@Book');
            my ($collection, $source) = $exampleSourceBookXML ?
                ($exampleSourceXML, $exampleSourceBookXML->get_node(1)->nodeValue()) : ('', $exampleSourceXML);
            if (!hasTable($source, $collection))
            {
                my $fullSource = $collection ? "$collection::$source" : $source;
                my $lemmaSign = $exampleNode->findnodes('ancestor::Lemma/@LemmaSign')->get_node(1)->nodeValue();
                warn "No table '$fullSource' found for entry '$lemmaSign'.\n";
            } else
            {
                $table = substTable($source, $collection);
            }
        }


        my $exampleTextAttr = $exampleNode->findnodes('Text/@Text')->get_node(1);
        my $transformedLine = transformLine($exampleTextAttr->nodeValue(), $table);

        $exampleTextAttr->setValue($transformedLine);
    }
    $dictDom->toFile("dictionary_processed.xml", 0)
}


1;