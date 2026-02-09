package LvSenie::Publishing::MetadataSql;
use strict;
use utf8;
use warnings;

use LvSenie::Utils::ExternalPropertyCatalog qw(getIndexType getExternalProperties getAllSources);

use Exporter();
use parent qw(Exporter);
our @EXPORT_OK = qw(processMetadataFile $BOOK_TABLE $AUTHOR_TABLE $GENRES_TABLE $BOOKS2AUTHORS_TABLE $BOOKS2GENRES_TABLE);

our ($BOOK_TABLE, $AUTHOR_TABLE, $GENRES_TABLE, $BOOKS2AUTHORS_TABLE, $BOOKS2GENRES_TABLE) =
    ('books', 'authors', 'genres', 'books_authors', 'books_genres');

sub processMetadataFile
{
    my $outForSQL = IO::File->new("insert_metadata_autogen.sql", "> :encoding(UTF-8)")
        or die "Could not open file insert_metadata_autogen.sql: $!";
    print $outForSQL "-- AUTOMATICALLY GENERATED metadata based on Sources/indexing.txt.\n\n";
    my @sources = @{getAllSources()};
    for my $full_source (@sources)
    {
        my $properties = getExternalProperties($full_source);
        my $sqlAuthor = $properties->{'author'};
        $sqlAuthor =~ s/\\/\\\\/g;
        $sqlAuthor =~ s/'/\\'/g;
        my $sqlTitle = $properties->{'short name'};
        $sqlTitle =~ s/\\/\\\\/g;
        $sqlTitle =~ s/'/\\'/g;
        # E.g., INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
        print $outForSQL "INSERT IGNORE INTO $AUTHOR_TABLE (name) VALUES ('$sqlAuthor');\n";
        # E.g., INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
        print $outForSQL "INSERT IGNORE INTO $GENRES_TABLE (name, subgenre) VALUES ('".$properties->{'genre'}."', FALSE);\n"
            if ($properties->{'genre'});
        # E.g., INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
        if ($properties->{'subgenre'})
        {
            for my $subgenre (@{$properties->{'subgenre'}})
            {
                print $outForSQL "INSERT IGNORE INTO $GENRES_TABLE (name, subgenre) VALUES ('$subgenre', TRUE);\n";
            }
        }
        # E.g.:
        # INSERT INTO books_new (full_source_code, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
        #   VALUES ('Apokr1689', 'Apokr1689', NULL, 'Apocrypha', 1689, 1689, 18, NULL, FALSE, 0);
        # INSERT INTO books_new (full_source_code, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
        #   VALUES ('Apokr1689/1Mak', 'Apokr1689', '1Mak', 'Ta Pirma Makkabeeŗu Grahmata', 1689, 1689, 18, 'GNP', FALSE, 7);
        # INSERT INTO books_new (full_source_code, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
        #   VALUES ('Baum1699_LVV', NULL, 'Baum1699_LVV', 'Labbajs wehleschanas Wahrds', 1699, 1699, 17, 'LR', FALSE, 0);

        print $outForSQL "INSERT INTO $BOOK_TABLE (full_source_code, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)\n";
        print $outForSQL "  VALUES ('$full_source', ";
        print $outForSQL $properties->{'collection id'} ? "'".$properties->{'collection id'}."', " : 'NULL, ';
        print $outForSQL $properties->{'short id'} ? "'".$properties->{'short id'}."', " : 'NULL, ';
        print $outForSQL "'$sqlTitle', '".$properties->{'year begin'}."', '"
            .$properties->{'year end'}."', '".$properties->{'century'}."', ";
        print $outForSQL ($properties->{'index'} and $properties->{'index'} ne '_') ? "'".$properties->{'index'}."', " : 'NULL, ';
        print $outForSQL $properties->{'manuscript'} ? 'TRUE, ' : 'FALSE, ';
        print $outForSQL $properties->{'order no'} ? $properties->{'order no'}.");\n" : "0);\n";

        # E.g.,
        # INSERT INTO books_authors_new (source, author_id, is_cover_author)
        #   VALUES ( 'Apokr1689', SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
        print $outForSQL "INSERT INTO $BOOKS2AUTHORS_TABLE (source, author_id, is_cover_author)\n";
        print $outForSQL "  VALUES ( '$full_source', (SELECT id FROM $AUTHOR_TABLE WHERE $AUTHOR_TABLE.name = '$sqlAuthor'), TRUE)\n";
        print $outForSQL "  ON DUPLICATE KEY UPDATE is_cover_author = TRUE, is_fragment_author = (is_fragment_author OR FALSE);\n";

        # E.g.,
        # INSERT INTO books_genres_new (source, genre_id)
        #   VALUES ( 'Apokr1689', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
        if ($properties->{'genre'} and $properties->{'genre'} ne '_')
        {
            print $outForSQL "INSERT INTO $BOOKS2GENRES_TABLE (source, genre_id)\n";
            print $outForSQL "  VALUES ( '$full_source', (SELECT id FROM $GENRES_TABLE WHERE $GENRES_TABLE.name = '".
                $properties->{'genre'}."'));\n";
        }
        if ($properties->{'subgenre'})
        {
            for my $subgenre (@{$properties->{'subgenre'}})
            {
                print $outForSQL "INSERT INTO $BOOKS2GENRES_TABLE (source, genre_id)\n";
                print $outForSQL "  VALUES ( '$full_source', (SELECT id FROM $GENRES_TABLE WHERE $GENRES_TABLE.name = '$subgenre'));\n";
            }
        }
        print $outForSQL "\n";
    }

    $outForSQL->close();
}

1;