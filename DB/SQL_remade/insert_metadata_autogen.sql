-- AUTOMATICALLY GENERATED metadata based on Sources/indexing.txt.

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lūgšanas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('AP1622', NULL, 'AP1622', 'Agenda Parva', '1622', '1622', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'AP1622', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'AP1622', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'AP1622', (SELECT id FROM genres_new WHERE genres_new.name = 'lūgšanas'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689', 'Apokr1689', NULL, 'Apocrypha', '1689', '1689', '17', NULL, FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689/1Mak', 'Apokr1689', '1Mak', 'Ta Pirma Makkabeeŗu Grahmata', '1689', '1689', '17', 'GNP', FALSE, 7);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689/1Mak', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/1Mak', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/1Mak', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/1Mak', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689/2Mak', 'Apokr1689', '2Mak', 'Ta Ohtra Makkabeeŗu Grahmata', '1689', '1689', '17', 'GNP', FALSE, 8);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689/2Mak', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/2Mak', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/2Mak', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/2Mak', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689/Asar', 'Apokr1689', 'Asar', 'Asarijus Luhgschana', '1689', '1689', '17', 'GNP', FALSE, 12);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689/Asar', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Asar', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Asar', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Asar', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689/Bar', 'Apokr1689', 'Bar', 'Bahruka Grahmata', '1689', '1689', '17', 'GNP', FALSE, 6);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689/Bar', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Bar', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Bar', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Bar', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689/Bel', 'Apokr1689', 'Bel', 'No ta Bela eeksch Bahbeles', '1689', '1689', '17', 'GNP', FALSE, 11);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689/Bel', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Bel', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Bel', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Bel', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689/GabpEst', 'Apokr1689', 'GabpEst', 'Gabbali pee Esteres Grahmatas', '1689', '1689', '17', 'GNP', FALSE, 9);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689/GabpEst', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/GabpEst', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/GabpEst', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/GabpEst', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689/Jd', 'Apokr1689', 'Jd', 'Juhdites Grahmata', '1689', '1689', '17', 'GNP', FALSE, 1);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689/Jd', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Jd', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Jd', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Jd', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689/Man', 'Apokr1689', 'Man', 'Manassus ta Ķehniņa no Juhda Luhgschana', '1689', '1689', '17', 'GNP', FALSE, 13);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689/Man', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Man', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Man', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Man', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689/P_Sir', 'Apokr1689', 'P_Sir', 'Jesus Sihraka pirma Eesahkschanas=Walloda', '1689', '1689', '17', 'GNP', FALSE, 4);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689/P_Sir', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/P_Sir', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/P_Sir', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/P_Sir', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689/Prolog', 'Apokr1689', 'Prolog', '[Apokrifu ievads un satura rādītājs]', '1689', '1689', '17', 'GLR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689/Prolog', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Prolog', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Prolog', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Prolog', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689/Sal', 'Apokr1689', 'Sal', 'Salamaņa Gudribas Grahmata', '1689', '1689', '17', 'GNP', FALSE, 2);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689/Sal', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Sal', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Sal', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Sal', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689/Sir', 'Apokr1689', 'Sir', 'Sihraka Gudribas Grahmata', '1689', '1689', '17', 'GNP', FALSE, 5);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689/Sir', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Sir', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Sir', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Sir', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689/Sus', 'Apokr1689', 'Sus', 'Stahsti no tahs Susannas un Danijeļa', '1689', '1689', '17', 'GNP', FALSE, 10);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689/Sus', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Sus', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Sus', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Sus', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Apokr1689/Tob', 'Apokr1689', 'Tob', 'Tobijus Grahmata', '1689', '1689', '17', 'GNP', FALSE, 3);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Apokr1689/Tob', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Tob', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Tob', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Apokr1689/Tob', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Andreass Baumans');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Baum1699_LVV', NULL, 'Baum1699_LVV', 'Labbajs wehleschanas Wahrds', '1699', '1699', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Baum1699_LVV', (SELECT id FROM authors_new WHERE authors_new.name = 'Andreass Baumans'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Baum1699_LVV', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Baum1699_LVV', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('Johans Kristofs Baumbahs');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Baumb1795_WLWJD', NULL, 'Baumb1795_WLWJD', 'Wezza Leejes Wihra Jahņu Dseesma', '1795', '1795', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Baumb1795_WLWJD', (SELECT id FROM authors_new WHERE authors_new.name = 'Johans Kristofs Baumbahs'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Baumb1795_WLWJD', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Baumb1795_WLWJD', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('Oto Johans Blūms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Bluhm1791_MWU', NULL, 'Bluhm1791_MWU', 'Muhs\' wissu Uppurs', '1791', '1791', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Bluhm1791_MWU', (SELECT id FROM authors_new WHERE authors_new.name = 'Oto Johans Blūms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Bluhm1791_MWU', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Bluhm1791_MWU', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('Bruno');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('tēvreizes', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Br1520_PN', NULL, 'Br1520_PN', '[Bruno tēvreize]', '1520', '1520', '16', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Br1520_PN', (SELECT id FROM authors_new WHERE authors_new.name = 'Bruno'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Br1520_PN', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Br1520_PN', (SELECT id FROM genres_new WHERE genres_new.name = 'tēvreizes'));

INSERT IGNORE INTO authors_new (name) VALUES ('Mihaels Ernsts Brīns');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Bruehn1756_DLWS', NULL, 'Bruehn1756_DLWS', 'Dseesma Latweescha Walloda sarakstita', '1756', '1756', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Bruehn1756_DLWS', (SELECT id FROM authors_new WHERE authors_new.name = 'Mihaels Ernsts Brīns'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Bruehn1756_DLWS', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Bruehn1756_DLWS', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('katehisms', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('CC1585', NULL, 'CC1585', 'Catechismvs Catholicorum', '1585', '1585', '16', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'CC1585', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'CC1585', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'CC1585', (SELECT id FROM genres_new WHERE genres_new.name = 'katehisms'));

INSERT IGNORE INTO authors_new (name) VALUES ('Francs Johans Cekels');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('padomu grāmata', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('CekFJ1790_KD', NULL, 'CekFJ1790_KD', 'Kartoppelu Dahrs', '1790', '1790', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'CekFJ1790_KD', (SELECT id FROM authors_new WHERE authors_new.name = 'Francs Johans Cekels'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'CekFJ1790_KD', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'CekFJ1790_KD', (SELECT id FROM genres_new WHERE genres_new.name = 'padomu grāmata'));

INSERT IGNORE INTO authors_new (name) VALUES ('Frīdrihs Vilhelms Cekels');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('CekFV1796_NL', NULL, 'CekFV1796_NL', 'Neapskahpjami Likkumi', '1796', '1796', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'CekFV1796_NL', (SELECT id FROM authors_new WHERE authors_new.name = 'Frīdrihs Vilhelms Cekels'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'CekFV1796_NL', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));

INSERT IGNORE INTO authors_new (name) VALUES ('Liborijs Depkins');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lūgšanas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Depk1681_90_ms', NULL, 'Depk1681_90_ms', 'Mīļi draugi', '1681', '1690', '17', 'LR', TRUE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Depk1681_90_ms', (SELECT id FROM authors_new WHERE authors_new.name = 'Liborijs Depkins'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Depk1681_90_ms', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Depk1681_90_ms', (SELECT id FROM genres_new WHERE genres_new.name = 'lūgšanas'));

INSERT IGNORE INTO authors_new (name) VALUES ('Liborijs Depkins');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Depk1703_TSD', NULL, 'Depk1703_TSD', 'Jahna Stakkela Gauda=Dseesma', '1703', '1703', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Depk1703_TSD', (SELECT id FROM authors_new WHERE authors_new.name = 'Liborijs Depkins'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Depk1703_TSD', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Depk1703_TSD', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('Liborijs Depkins');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vārdnīcas', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('vārdnīca', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Depk1704_Vortr', NULL, 'Depk1704_Vortr', 'Vortrab', '1704', '1704', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Depk1704_Vortr', (SELECT id FROM authors_new WHERE authors_new.name = 'Liborijs Depkins'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Depk1704_Vortr', (SELECT id FROM genres_new WHERE genres_new.name = 'Vārdnīcas'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Depk1704_Vortr', (SELECT id FROM genres_new WHERE genres_new.name = 'vārdnīca'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Dresels');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('katehisms', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Dres1682_SBM', NULL, 'Dres1682_SBM', 'Swähta Bährno=Mahziba', '1682', '1682', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Dres1682_SBM', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Dresels'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Dres1682_SBM', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Dres1682_SBM', (SELECT id FROM genres_new WHERE genres_new.name = 'katehisms'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lietišķie teksti', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('zvēresti', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Eid1701_KB', NULL, 'Eid1701_KB', 'Eid der Treue vor die Lettische Artillerie=Bediente, KB', '1701', '1701', '18', 'P', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Eid1701_KB', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Eid1701_KB', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Eid1701_KB', (SELECT id FROM genres_new WHERE genres_new.name = 'lietišķie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Eid1701_KB', (SELECT id FROM genres_new WHERE genres_new.name = 'zvēresti'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lietišķie teksti', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('zvēresti', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Eid1701_RA', NULL, 'Eid1701_RA', 'Eid der Treue vor die Lettische Artillerie=Bediente, RA', '1701', '1701', '18', 'P', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Eid1701_RA', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Eid1701_RA', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Eid1701_RA', (SELECT id FROM genres_new WHERE genres_new.name = 'lietišķie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Eid1701_RA', (SELECT id FROM genres_new WHERE genres_new.name = 'zvēresti'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Elgers');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('dziesmas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Elg1621_GCG', NULL, 'Elg1621_GCG', 'Geistliche Catholische Gesänge', '1621', '1621', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Elg1621_GCG', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Elgers'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Elg1621_GCG', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Elg1621_GCG', (SELECT id FROM genres_new WHERE genres_new.name = 'dziesmas'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Elgers');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('katehisms', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Elg1672_Cat', NULL, 'Elg1672_Cat', 'Catechismus', '1672', '1672', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Elg1672_Cat', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Elgers'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Elg1672_Cat', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Elg1672_Cat', (SELECT id FROM genres_new WHERE genres_new.name = 'katehisms'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Elgers');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lūgšanas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Elg1672_EvTA', NULL, 'Elg1672_EvTA', 'Evangelia toto anno singulis dominicis et festis', '1672', '1672', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Elg1672_EvTA', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Elgers'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Elg1672_EvTA', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Elg1672_EvTA', (SELECT id FROM genres_new WHERE genres_new.name = 'lūgšanas'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Elgers');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('dziesmas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Elg1673_CS', NULL, 'Elg1673_CS', 'Cantiones Spirituales', '1673', '1673', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Elg1673_CS', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Elgers'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Elg1673_CS', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Elg1673_CS', (SELECT id FROM genres_new WHERE genres_new.name = 'dziesmas'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Elgers');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vārdnīcas', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('vārdnīca', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Elg1683_DictPLL', NULL, 'Elg1683_DictPLL', 'Dictionarivm Polono-Latino-Lottauicum', '1683', '1683', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Elg1683_DictPLL', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Elgers'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Elg1683_DictPLL', (SELECT id FROM genres_new WHERE genres_new.name = 'Vārdnīcas'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Elg1683_DictPLL', (SELECT id FROM genres_new WHERE genres_new.name = 'vārdnīca'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('katehisms', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Ench1586', NULL, 'Ench1586', 'Enchiridion, 1586', '1586', '1586', '16', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Ench1586', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Ench1586', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Ench1586', (SELECT id FROM genres_new WHERE genres_new.name = 'katehisms'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('katehisms', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Ench1615', NULL, 'Ench1615', 'Enchiridion, 1615', '1615', '1615', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Ench1615', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Ench1615', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Ench1615', (SELECT id FROM genres_new WHERE genres_new.name = 'katehisms'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('EvEp1587', NULL, 'EvEp1587', 'Euangelia vnd Episteln, 1587', '1587', '1587', '16', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'EvEp1587', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'EvEp1587', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'EvEp1587', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'EvEp1587', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('EvEp1615', NULL, 'EvEp1615', 'Euangelia vnd Episteln, 1615', '1615', '1615', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'EvEp1615', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'EvEp1615', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'EvEp1615', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'EvEp1615', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('EvTA1753', NULL, 'EvTA1753', 'Evangelia Toto Anno', '1753', '1753', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'EvTA1753', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'EvTA1753', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'EvTA1753', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'EvTA1753', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Kristofs Fīrekers');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vārdnīcas', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('vārdnīca', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Fuer1650_70_1ms', NULL, 'Fuer1650_70_1ms', 'Lettisches und Teutsches Wörterbuch', '1650', '1670', '17', 'LR', TRUE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Fuer1650_70_1ms', (SELECT id FROM authors_new WHERE authors_new.name = 'Kristofs Fīrekers'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Fuer1650_70_1ms', (SELECT id FROM genres_new WHERE genres_new.name = 'Vārdnīcas'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Fuer1650_70_1ms', (SELECT id FROM genres_new WHERE genres_new.name = 'vārdnīca'));

INSERT IGNORE INTO authors_new (name) VALUES ('Kristofs Fīrekers');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vārdnīcas', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('vārdnīca', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Fuer1650_70_2ms', NULL, 'Fuer1650_70_2ms', 'Lettisch-deutsches Wörterbuch', '1650', '1670', '17', 'LR', TRUE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Fuer1650_70_2ms', (SELECT id FROM authors_new WHERE authors_new.name = 'Kristofs Fīrekers'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Fuer1650_70_2ms', (SELECT id FROM genres_new WHERE genres_new.name = 'Vārdnīcas'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Fuer1650_70_2ms', (SELECT id FROM genres_new WHERE genres_new.name = 'vārdnīca'));

INSERT IGNORE INTO authors_new (name) VALUES ('Heinrihs Fūrmans');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Fuhr1690_LL', NULL, 'Fuhr1690_LL', 'Laimiga Lauliba', '1690', '1690', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Fuhr1690_LL', (SELECT id FROM authors_new WHERE authors_new.name = 'Heinrihs Fūrmans'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Fuhr1690_LL', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Fuhr1690_LL', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('GD_1698', NULL, 'GD_1698', 'Gohda=Dseesma', '1698', '1698', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'GD_1698', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'GD_1698', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'GD_1698', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('Nikolajs Gisberts');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('tēvreizes', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Gis1507_PN', NULL, 'Gis1507_PN', '[Gisberta tēvreize]', '1507', '1507', '16', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Gis1507_PN', (SELECT id FROM authors_new WHERE authors_new.name = 'Nikolajs Gisberts'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Gis1507_PN', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Gis1507_PN', (SELECT id FROM genres_new WHERE genres_new.name = 'tēvreizes'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('katehisms', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Glueck1699_SBM', NULL, 'Glueck1699_SBM', 'Swehta Behrnu=Mahziba', '1699', '1699', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Glueck1699_SBM', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Glueck1699_SBM', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Glueck1699_SBM', (SELECT id FROM genres_new WHERE genres_new.name = 'katehisms'));

INSERT IGNORE INTO authors_new (name) VALUES ('Simons Grūnavs');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('tēvreizes', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Gr1520_PN', NULL, 'Gr1520_PN', '[Grūnava tēvreize]', '1520', '1520', '16', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Gr1520_PN', (SELECT id FROM authors_new WHERE authors_new.name = 'Simons Grūnavs'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Gr1520_PN', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Gr1520_PN', (SELECT id FROM genres_new WHERE genres_new.name = 'tēvreizes'));

INSERT IGNORE INTO authors_new (name) VALUES ('Nikolauss Kristofers Hāgemeisters');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('padomu grāmata', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Hag1790_IM', NULL, 'Hag1790_IM', 'Ihsa Mahziba Preeksch Latweescheem', '1790', '1790', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Hag1790_IM', (SELECT id FROM authors_new WHERE authors_new.name = 'Nikolauss Kristofers Hāgemeisters'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Hag1790_IM', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Hag1790_IM', (SELECT id FROM genres_new WHERE genres_new.name = 'padomu grāmata'));

INSERT IGNORE INTO authors_new (name) VALUES ('Johans Hazentēters');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('tēvreizes', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Has1550_PN', NULL, 'Has1550_PN', '[Hazentētera tēvreize]', '1550', '1550', '16', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Has1550_PN', (SELECT id FROM authors_new WHERE authors_new.name = 'Johans Hazentēters'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Has1550_PN', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Has1550_PN', (SELECT id FROM genres_new WHERE genres_new.name = 'tēvreizes'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685', 'JT1685', NULL, 'Tas Jauns Testaments', '1685', '1685', '17', NULL, FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/1J', 'JT1685', '1J', 'Jahņa ta Apustuļa pirma Grahmata uhs wisseem rakstita', '1685', '1685', '17', 'GNP', FALSE, 21);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/1J', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1J', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1J', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1J', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/1Kor', 'JT1685', '1Kor', 'Pahwila ta Apustuļa pirma Grahmata uhs teem Korinteŗeem rakstita', '1685', '1685', '17', 'GNP', FALSE, 7);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/1Kor', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1Kor', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1Kor', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1Kor', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/1P', 'JT1685', '1P', 'Pehteŗa ta Apustuļa pirma Grahmata uhs wisseem rakstita', '1685', '1685', '17', 'GNP', FALSE, 19);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/1P', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1P', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1P', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1P', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/1Tes', 'JT1685', '1Tes', 'Pahwila ta Apustuļa pirma Grahmata uhs teem Tessalonikeŗeem rakstita', '1685', '1685', '17', 'GNP', FALSE, 13);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/1Tes', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1Tes', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1Tes', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1Tes', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/1Tim', 'JT1685', '1Tim', 'Pahwila ta Apustuļa pirma Grahmata uhs Timoteju rakstita', '1685', '1685', '17', 'GNP', FALSE, 15);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/1Tim', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1Tim', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1Tim', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/1Tim', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/2J', 'JT1685', '2J', 'Jahņa ta Apustuļa ohtra Grahmata uhs wisseem rakstita', '1685', '1685', '17', 'GNP', FALSE, 22);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/2J', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2J', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2J', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2J', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/2Kor', 'JT1685', '2Kor', 'Pahwila ta Apustuļa ohtra Grahmata uhs teem Korinteŗeem rakstita', '1685', '1685', '17', 'GNP', FALSE, 8);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/2Kor', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2Kor', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2Kor', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2Kor', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/2P', 'JT1685', '2P', 'Pehteŗa ta Apustuļa ohtra Grahmata uhs wisseem rakstita', '1685', '1685', '17', 'GNP', FALSE, 20);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/2P', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2P', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2P', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2P', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/2Tes', 'JT1685', '2Tes', 'Pahwila ta Apustuļa ohtra Grahmata uhs teem Tessalonikeŗeem rakstita', '1685', '1685', '17', 'GNP', FALSE, 14);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/2Tes', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2Tes', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2Tes', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2Tes', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/2Tim', 'JT1685', '2Tim', 'Pahwila ta Apustuļa ohtra Grahmata uhs Timoteju rakstita', '1685', '1685', '17', 'GNP', FALSE, 16);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/2Tim', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2Tim', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2Tim', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/2Tim', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/3J', 'JT1685', '3J', 'Jahņa ta Apustuļa trescha Grahmata', '1685', '1685', '17', 'GNP', FALSE, 23);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/3J', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/3J', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/3J', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/3J', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Apd', 'JT1685', 'Apd', 'Tee Darbi To Swehtu Apustuļu', '1685', '1685', '17', 'GNP', FALSE, 5);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Apd', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Apd', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Apd', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Apd', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Atk', 'JT1685', 'Atk', 'Ta Swehta Deewa=Mahzitaja Jahņa Parahdischanas=Grahmata', '1685', '1685', '17', 'GNP', FALSE, 27);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Atk', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Atk', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Atk', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Atk', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Ebr', 'JT1685', 'Ebr', 'Grahmata uhs teem Ebreeŗeem rakstita', '1685', '1685', '17', 'GNP', FALSE, 24);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Ebr', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Ebr', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Ebr', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Ebr', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Ef', 'JT1685', 'Ef', 'Pahwila ta Apustuļa Grahmata uhs teem Eweseŗeem rakstita', '1685', '1685', '17', 'GNP', FALSE, 10);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Ef', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Ef', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Ef', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Ef', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Fil', 'JT1685', 'Fil', 'Pahwila ta Apustuļa Grahmata uhs teem Wilippeŗeem rakstita', '1685', '1685', '17', 'GNP', FALSE, 11);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Fil', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Fil', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Fil', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Fil', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Flm', 'JT1685', 'Flm', 'Pahwila ta Apustula Grahmata uhs Wilemonu rakstita', '1685', '1685', '17', 'GNP', FALSE, 18);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Flm', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Flm', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Flm', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Flm', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Gal', 'JT1685', 'Gal', 'Pahwila ta Apustuļa Grahmata uhs teem Galateŗeem rakstita', '1685', '1685', '17', 'GNP', FALSE, 9);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Gal', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Gal', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Gal', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Gal', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Jk', 'JT1685', 'Jk', 'Jehkaba ta Apustuļa Grahmata us wisseem rakstita', '1685', '1685', '17', 'GNP', FALSE, 25);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Jk', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Jk', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Jk', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Jk', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Jn', 'JT1685', 'Jn', 'Tas Ewangeljums No Swehta Jahņa uhsrakstihts', '1685', '1685', '17', 'GNP', FALSE, 4);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Jn', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Jn', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Jn', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Jn', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Jud', 'JT1685', 'Jud', 'Juhda ta Apustuļa Grahmata uhs wisseem rakstita', '1685', '1685', '17', 'GNP', FALSE, 26);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Jud', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Jud', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Jud', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Jud', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Kol', 'JT1685', 'Kol', 'Pahwila ta Apustuļa Grahmata uhs teem Kolosseŗeem rakstita', '1685', '1685', '17', 'GNP', FALSE, 12);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Kol', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Kol', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Kol', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Kol', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Lk', 'JT1685', 'Lk', 'Tas Ewangeljums No Swehta Luhkasa usrakstihts', '1685', '1685', '17', 'GNP', FALSE, 3);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Lk', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Lk', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Lk', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Lk', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Mk', 'JT1685', 'Mk', 'Tas Ewangeljums No Swehta Markussa usrakstihts', '1685', '1685', '17', 'GNP', FALSE, 2);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Mk', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Mk', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Mk', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Mk', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Mt', 'JT1685', 'Mt', 'Tas Ewangeliums No Swehta Matteusa usrakstihts', '1685', '1685', '17', 'GNP', FALSE, 1);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Mt', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Mt', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Mt', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Mt', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Prolog_Iev', 'JT1685', 'Prolog_Iev', '[Jaunās Derības ievads]', '1685', '1685', '17', 'GLR', FALSE, 0.3);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Prolog_Iev', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Prolog_Iev', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Prolog_Iev', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Prolog_Iev', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Prolog_Sat', 'JT1685', 'Prolog_Sat', '[Jaunās Derības satura rādītājs]', '1685', '1685', '17', 'GLR', FALSE, 0.2);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Prolog_Sat', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Prolog_Sat', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Prolog_Sat', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Prolog_Sat', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Prolog_Tit', 'JT1685', 'Prolog_Tit', '[Jaunās Derības titullapa]', '1685', '1685', '17', 'GLR', FALSE, 0.1);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Prolog_Tit', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Prolog_Tit', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Prolog_Tit', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Prolog_Tit', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Rm', 'JT1685', 'Rm', 'Pahwila ta Apustuļa Grahmata us teem Reemeŗeem rakstita', '1685', '1685', '17', 'GNP', FALSE, 6);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Rm', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Rm', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Rm', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Rm', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('JT1685/Tit', 'JT1685', 'Tit', 'Pahwila ta Apustuļa Grahmata uhs Titu rakstita', '1685', '1685', '17', 'GNP', FALSE, 17);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'JT1685/Tit', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Tit', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Tit', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'JT1685/Tit', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Heinrihs Kleinšmits');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lūgšanas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Klein1672_LPG', NULL, 'Klein1672_LPG', 'Lattweescho Pataro=Ghramata', '1672', '1672', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Klein1672_LPG', (SELECT id FROM authors_new WHERE authors_new.name = 'Heinrihs Kleinšmits'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Klein1672_LPG', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Klein1672_LPG', (SELECT id FROM genres_new WHERE genres_new.name = 'lūgšanas'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('dziesmas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('LGL1685_K1', NULL, 'LGL1685_K1', 'Lettische Geistliche Lieder und Collecten', '1685', '1685', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'LGL1685_K1', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'LGL1685_K1', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'LGL1685_K1', (SELECT id FROM genres_new WHERE genres_new.name = 'dziesmas'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('dziesmas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('LGL1685_V5', NULL, 'LGL1685_V5', 'Lettische Geistliche Lieder Und Psalmen', '1685', '1685', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'LGL1685_V5', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'LGL1685_V5', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'LGL1685_V5', (SELECT id FROM genres_new WHERE genres_new.name = 'dziesmas'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lūgšanas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('LPDD1704', NULL, 'LPDD1704', 'Luhgschanas preeksch Deewa draudses', '1704', '1704', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'LPDD1704', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'LPDD1704', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'LPDD1704', (SELECT id FROM genres_new WHERE genres_new.name = 'lūgšanas'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lietišķie teksti', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('LS1625', NULL, 'LS1625', '[Linaudēju šrāga]', '1625', '1625', '17', 'LR', TRUE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'LS1625', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'LS1625', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'LS1625', (SELECT id FROM genres_new WHERE genres_new.name = 'lietišķie teksti'));

INSERT IGNORE INTO authors_new (name) VALUES ('Johans Langijs');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vārdnīcas', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('vārdnīca', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Lang1685_LDL_ms', NULL, 'Lang1685_LDL_ms', 'Lettisch=Deutsches Lexicon', '1685', '1685', '17', 'LR', TRUE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Lang1685_LDL_ms', (SELECT id FROM authors_new WHERE authors_new.name = 'Johans Langijs'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Lang1685_LDL_ms', (SELECT id FROM genres_new WHERE genres_new.name = 'Vārdnīcas'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Lang1685_LDL_ms', (SELECT id FROM genres_new WHERE genres_new.name = 'vārdnīca'));

INSERT IGNORE INTO authors_new (name) VALUES ('Volfgangs Lācijs');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('tēvreizes', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Laz1557_PN', NULL, 'Laz1557_PN', '[Lācija tēvreize]', '1557', '1557', '16', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Laz1557_PN', (SELECT id FROM authors_new WHERE authors_new.name = 'Volfgangs Lācijs'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Laz1557_PN', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Laz1557_PN', (SELECT id FROM genres_new WHERE genres_new.name = 'tēvreizes'));

INSERT IGNORE INTO authors_new (name) VALUES ('Martins Gotlībs Agapetuss Loders');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('sprediķi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Lod1775_SEAPP', NULL, 'Lod1775_SEAPP', 'Spreddiķis pee Eeswehtischanas', '1775', '1775', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Lod1775_SEAPP', (SELECT id FROM authors_new WHERE authors_new.name = 'Martins Gotlībs Agapetuss Loders'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Lod1775_SEAPP', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Lod1775_SEAPP', (SELECT id FROM genres_new WHERE genres_new.name = 'sprediķi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Martins Gotlībs Agapetuss Loders');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('katehisms', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Lod1778_WTMD', NULL, 'Lod1778_WTMD', 'Wahrdi tahs muhschigas dsihwoschanas', '1778', '1778', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Lod1778_WTMD', (SELECT id FROM authors_new WHERE authors_new.name = 'Martins Gotlībs Agapetuss Loders'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Lod1778_WTMD', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Lod1778_WTMD', (SELECT id FROM genres_new WHERE genres_new.name = 'katehisms'));

INSERT IGNORE INTO authors_new (name) VALUES ('Johans Justins Lopenove');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('padomu grāmata', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Lop1800_SDLS', NULL, 'Lop1800_SDLS', 'Sarunnaschanas, starp diweem Latwiskeem Semneekem', '1800', '1800', '19', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Lop1800_SDLS', (SELECT id FROM authors_new WHERE authors_new.name = 'Johans Justins Lopenove'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Lop1800_SDLS', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Lop1800_SDLS', (SELECT id FROM genres_new WHERE genres_new.name = 'padomu grāmata'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('sprediķi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('MD1788', NULL, 'MD1788', 'Mihļi Draugi!', '1788', '1788', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'MD1788', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'MD1788', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'MD1788', (SELECT id FROM genres_new WHERE genres_new.name = 'sprediķi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('katehisms', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1631_Cat', NULL, 'Manc1631_Cat', 'Der kleine Catechismus, 1631', '1631', '1631', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1631_Cat', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1631_Cat', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1631_Cat', (SELECT id FROM genres_new WHERE genres_new.name = 'katehisms'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('dziesmas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1631_LGL', NULL, 'Manc1631_LGL', 'Lettische geistliche Lieder vnd Psalmen, 1631', '1631', '1631', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1631_LGL', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1631_LGL', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1631_LGL', (SELECT id FROM genres_new WHERE genres_new.name = 'dziesmas'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1631_LVM', NULL, 'Manc1631_LVM', 'Lettisch Vade mecum, 1631', '1631', '1631', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1631_LVM', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1631_LVM', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1631_LVM', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1631_Syr', NULL, 'Manc1631_Syr', 'Das Hauß=Zucht=vnd Lehrbuch Jesu Syrachs, 1631', '1631', '1631', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1631_Syr', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1631_Syr', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1631_Syr', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1631_Syr', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1637_Sal', NULL, 'Manc1637_Sal', 'Die Sprüche Salomonis', '1637', '1637', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1637_Sal', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1637_Sal', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1637_Sal', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1637_Sal', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vārdnīcas', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('vārdnīca', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1638_L', NULL, 'Manc1638_L', 'Lettus', '1638', '1638', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1638_L', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1638_L', (SELECT id FROM genres_new WHERE genres_new.name = 'Vārdnīcas'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1638_L', (SELECT id FROM genres_new WHERE genres_new.name = 'vārdnīca'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vārdnīcas', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('vārdnīca', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1638_PhL', NULL, 'Manc1638_PhL', 'Phraseologia Lettica', '1638', '1638', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1638_PhL', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1638_PhL', (SELECT id FROM genres_new WHERE genres_new.name = 'Vārdnīcas'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1638_PhL', (SELECT id FROM genres_new WHERE genres_new.name = 'vārdnīca'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1638_Run', NULL, 'Manc1638_Run', '[Desmit sarunas]', '1638', '1638', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1638_Run', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1638_Run', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('katehisms', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1643_44_Cat', NULL, 'Manc1643_44_Cat', 'Der kleine Catechismus, 1643', '1643', '1644', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1643_44_Cat', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1643_44_Cat', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1643_44_Cat', (SELECT id FROM genres_new WHERE genres_new.name = 'katehisms'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1643_44_LVM', NULL, 'Manc1643_44_LVM', 'Lettisch Vade mecum, 1643', '1643', '1644', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1643_44_LVM', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1643_44_LVM', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1643_44_LVM', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('dziesmas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1643_LGL', NULL, 'Manc1643_LGL', 'Lettische Geistliche Lieder vnd Psalmen, 1643', '1643', '1643', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1643_LGL', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1643_LGL', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1643_LGL', (SELECT id FROM genres_new WHERE genres_new.name = 'dziesmas'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1643_Syr', NULL, 'Manc1643_Syr', 'Das Hauß=Zucht=vnd Leerbuch Jesu Syrachs, 1643', '1643', '1643', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1643_Syr', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1643_Syr', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1643_Syr', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1643_Syr', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('sprediķi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1654_LP1', NULL, 'Manc1654_LP1', 'Lang=gewünschte Lettische Postill I', '1654', '1654', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1654_LP1', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1654_LP1', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1654_LP1', (SELECT id FROM genres_new WHERE genres_new.name = 'sprediķi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('sprediķi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1654_LP2', NULL, 'Manc1654_LP2', 'Lang=gewünschte Lettische Postill II', '1654', '1654', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1654_LP2', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1654_LP2', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1654_LP2', (SELECT id FROM genres_new WHERE genres_new.name = 'sprediķi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Georgs Mancelis');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('sprediķi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Manc1654_LP3', NULL, 'Manc1654_LP3', 'Lang=gewünschte Lettische Postill III', '1654', '1654', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Manc1654_LP3', (SELECT id FROM authors_new WHERE authors_new.name = 'Georgs Mancelis'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1654_LP3', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Manc1654_LP3', (SELECT id FROM genres_new WHERE genres_new.name = 'sprediķi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Hieronīms Megisers');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('tēvreizes', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Meg1593_PN', NULL, 'Meg1593_PN', '[Megisera tēvreize]', '1593', '1593', '16', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Meg1593_PN', (SELECT id FROM authors_new WHERE authors_new.name = 'Hieronīms Megisers'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Meg1593_PN', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Meg1593_PN', (SELECT id FROM genres_new WHERE genres_new.name = 'tēvreizes'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('dziesmas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Ps1615', NULL, 'Ps1615', 'Psalmen vnd geistliche Lieder', '1615', '1615', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Ps1615', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Ps1615', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Ps1615', (SELECT id FROM genres_new WHERE genres_new.name = 'dziesmas'));

INSERT IGNORE INTO authors_new (name) VALUES ('Kristians Rāvensbergs');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('sprediķi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Rav1767_SD', NULL, 'Rav1767_SD', 'Swehtas Dohmas', '1767', '1767', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Rav1767_SD', (SELECT id FROM authors_new WHERE authors_new.name = 'Kristians Rāvensbergs'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Rav1767_SD', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Rav1767_SD', (SELECT id FROM genres_new WHERE genres_new.name = 'sprediķi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Jānis Reiters');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('tēvreizes', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Reit1675_OD', NULL, 'Reit1675_OD', '[Reitera tēvreize]', '1675', '1675', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Reit1675_OD', (SELECT id FROM authors_new WHERE authors_new.name = 'Jānis Reiters'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Reit1675_OD', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Reit1675_OD', (SELECT id FROM genres_new WHERE genres_new.name = 'tēvreizes'));

INSERT IGNORE INTO authors_new (name) VALUES ('Jānis Reiters');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Jaunā Derība', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Reit1675_UeP', NULL, 'Reit1675_UeP', 'Eine Übersetungsprobe', '1675', '1675', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Reit1675_UeP', (SELECT id FROM authors_new WHERE authors_new.name = 'Jānis Reiters'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Reit1675_UeP', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Reit1675_UeP', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Reit1675_UeP', (SELECT id FROM genres_new WHERE genres_new.name = 'Jaunā Derība'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Reit1675_UeP', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lietišķie teksti', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('SKL1696_KB', NULL, 'SKL1696_KB', 'Sawadi Karra=Teesas Likkumi, KB', '1696', '1696', '17', 'P', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'SKL1696_KB', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'SKL1696_KB', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'SKL1696_KB', (SELECT id FROM genres_new WHERE genres_new.name = 'lietišķie teksti'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lietišķie teksti', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('SKL1696_RA', NULL, 'SKL1696_RA', 'Sawadi Karra=Teesas Likkumi, RA', '1696', '1696', '17', 'P', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'SKL1696_RA', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'SKL1696_RA', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'SKL1696_RA', (SELECT id FROM genres_new WHERE genres_new.name = 'lietišķie teksti'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lietišķie teksti', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('SL1684', NULL, 'SL1684', 'Sohdu=Likkums prett to Behrno=Muschinaschanu', '1684', '1684', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'SL1684', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'SL1684', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'SL1684', (SELECT id FROM genres_new WHERE genres_new.name = 'lietišķie teksti'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('SL1789', NULL, 'SL1789', 'Skohlas=Likkumi', '1789', '1789', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'SL1789', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'SL1789', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('SLM1648', NULL, 'SLM1648', 'Starpan to lele meže', '1648', '1648', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'SLM1648', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'SLM1648', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'SLM1648', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('Aleksandrs Johans Stenders');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('luga', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('StendAJ1790_LSMP', NULL, 'StendAJ1790_LSMP', 'Lustesspehle no Semmneeka kas par Muischneeku tappe pahrwehrsts', '1790', '1790', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'StendAJ1790_LSMP', (SELECT id FROM authors_new WHERE authors_new.name = 'Aleksandrs Johans Stenders'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'StendAJ1790_LSMP', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'StendAJ1790_LSMP', (SELECT id FROM genres_new WHERE genres_new.name = 'luga'));

INSERT IGNORE INTO authors_new (name) VALUES ('Aleksandrs Johans Stenders');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('StendAJ1793_JGW', NULL, 'StendAJ1793_JGW', 'Jauna=Gadda Wehleschanas, 1793', '1793', '1793', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'StendAJ1793_JGW', (SELECT id FROM authors_new WHERE authors_new.name = 'Aleksandrs Johans Stenders'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'StendAJ1793_JGW', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'StendAJ1793_JGW', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('Gothards Frīdrihs Stenders');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('populārzinātnisks izdevums', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('StendGF1774_AGG', NULL, 'StendGF1774_AGG', 'Augstas Gudribas Grahmata', '1774', '1774', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'StendGF1774_AGG', (SELECT id FROM authors_new WHERE authors_new.name = 'Gothards Frīdrihs Stenders'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'StendGF1774_AGG', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'StendGF1774_AGG', (SELECT id FROM genres_new WHERE genres_new.name = 'populārzinātnisks izdevums'));

INSERT IGNORE INTO authors_new (name) VALUES ('Gothards Frīdrihs Stenders');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('StendGF1781_JGW', NULL, 'StendGF1781_JGW', 'Jauna Gadda Wehleschanas, 1781', '1781', '1781', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'StendGF1781_JGW', (SELECT id FROM authors_new WHERE authors_new.name = 'Gothards Frīdrihs Stenders'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'StendGF1781_JGW', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'StendGF1781_JGW', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('Gothards Frīdrihs Stenders');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('StendGF1789_SL', NULL, 'StendGF1789_SL', 'Siņģu Lustes', '1789', '1789', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'StendGF1789_SL', (SELECT id FROM authors_new WHERE authors_new.name = 'Gothards Frīdrihs Stenders'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'StendGF1789_SL', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'StendGF1789_SL', (SELECT id FROM genres_new WHERE genres_new.name = 'dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('Matiass Stobe');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Stobbe1796_PTK', NULL, 'Stobbe1796_PTK', 'Pee ta Kappa ta zeeniga G. W. Stendera', '1796', '1796', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Stobbe1796_PTK', (SELECT id FROM authors_new WHERE authors_new.name = 'Matiass Stobe'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Stobbe1796_PTK', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Stobbe1796_PTK', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('Karls Frīdrihs Šulcs');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lietišķie teksti', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Sulc1764_ARMST', NULL, 'Sulc1764_ARMST', 'Aiskrauknes= un Rihmaņa=Muischas Semneeku Teesa', '1764', '1764', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Sulc1764_ARMST', (SELECT id FROM authors_new WHERE authors_new.name = 'Karls Frīdrihs Šulcs'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Sulc1764_ARMST', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Sulc1764_ARMST', (SELECT id FROM genres_new WHERE genres_new.name = 'lietišķie teksti'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('katehisms', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('TII1790', NULL, 'TII1790', 'Ta Jhsa Jsstahstischana', '1790', '1790', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'TII1790', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'TII1790', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'TII1790', (SELECT id FROM genres_new WHERE genres_new.name = 'katehisms'));

INSERT IGNORE INTO authors_new (name) VALUES ('Karls Ludvigs Tečs');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Tetsch1784_DKTW', NULL, 'Tetsch1784_DKTW', 'Dseŗŗeet, Kruhschkalls Tautu Wihri!', '1784', '1784', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Tetsch1784_DKTW', (SELECT id FROM authors_new WHERE authors_new.name = 'Karls Ludvigs Tečs'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Tetsch1784_DKTW', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Tetsch1784_DKTW', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('Andrē Tevē');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('tēvreizes', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Thev1575_PN', NULL, 'Thev1575_PN', '[Tevē tēvreize]', '1575', '1575', '16', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Thev1575_PN', (SELECT id FROM authors_new WHERE authors_new.name = 'Andrē Tevē'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Thev1575_PN', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Thev1575_PN', (SELECT id FROM genres_new WHERE genres_new.name = 'tēvreizes'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lūgšanas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('UKG1693', NULL, 'UKG1693', 'Unterschiedliche Kirchen=Gebete', '1693', '1693', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'UKG1693', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'UKG1693', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'UKG1693', (SELECT id FROM genres_new WHERE genres_new.name = 'lūgšanas'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lūgšanas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('UKG1696', NULL, 'UKG1696', 'Unterschiedliche Kirchen=Gebete', '1696', '1696', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'UKG1696', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'UKG1696', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'UKG1696', (SELECT id FROM genres_new WHERE genres_new.name = 'lūgšanas'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('dziesmas', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('UP1587', NULL, 'UP1587', 'Vndeudsche Psalmen', '1587', '1587', '16', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'UP1587', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'UP1587', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'UP1587', (SELECT id FROM genres_new WHERE genres_new.name = 'dziesmas'));

INSERT IGNORE INTO authors_new (name) VALUES ('Frīdrihs Kazimirs Urbāns');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Urban1791_LKLDD', NULL, 'Urban1791_LKLDD', 'Labs Kungs leela Deewa Dahwana', '1791', '1791', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Urban1791_LKLDD', (SELECT id FROM authors_new WHERE authors_new.name = 'Frīdrihs Kazimirs Urbāns'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Urban1791_LKLDD', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Urban1791_LKLDD', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('Sila zemnieks Anšs');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('vēstules', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('V1771_SZA', NULL, 'V1771_SZA', '[Sila zemnieka Anša vēstule mācītājam Loderam]', '1771', '1771', '18', 'LR', TRUE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'V1771_SZA', (SELECT id FROM authors_new WHERE authors_new.name = 'Sila zemnieks Anšs'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'V1771_SZA', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'V1771_SZA', (SELECT id FROM genres_new WHERE genres_new.name = 'vēstules'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94', 'VD1689_94', NULL, 'Ta Swehta Grahmata', '1689', '1694', '17', NULL, FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/1Ken', 'VD1689_94', '1Ken', 'Ta pirma Grahmata no teem Ķehniņeem', '1689', '1694', '17', 'GNP', FALSE, 11);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/1Ken', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/1Ken', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/1Ken', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/1Ken', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/1L', 'VD1689_94', '1L', 'Ta pirma Laiku=Grahmata', '1689', '1694', '17', 'GNP', FALSE, 13);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/1L', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/1L', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/1L', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/1L', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/1Moz', 'VD1689_94', '1Moz', 'Ta Pirma Mohsus Grahmata', '1689', '1694', '17', 'GNP', FALSE, 1);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/1Moz', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/1Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/1Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/1Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/1Sam', 'VD1689_94', '1Sam', 'Ta pirma Samueļa Grahmata', '1689', '1694', '17', 'GNP', FALSE, 9);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/1Sam', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/1Sam', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/1Sam', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/1Sam', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/2Ken', 'VD1689_94', '2Ken', 'Ta ohtra Grahmata no teem Ķehniņeem', '1689', '1694', '17', 'GNP', FALSE, 12);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/2Ken', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/2Ken', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/2Ken', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/2Ken', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/2L', 'VD1689_94', '2L', 'Ta ohtra Laiku=Grahmata', '1689', '1694', '17', 'GNP', FALSE, 14);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/2L', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/2L', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/2L', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/2L', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/2Moz', 'VD1689_94', '2Moz', 'Ta Ohtra Mohsus Grahmata', '1689', '1694', '17', 'GNP', FALSE, 2);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/2Moz', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/2Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/2Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/2Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/2Sam', 'VD1689_94', '2Sam', 'Ta ohtra Samueļa Grahmata', '1689', '1694', '17', 'GNP', FALSE, 10);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/2Sam', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/2Sam', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/2Sam', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/2Sam', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/3Moz', 'VD1689_94', '3Moz', 'Ta Trescha Mohsus Grahmata', '1689', '1694', '17', 'GNP', FALSE, 3);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/3Moz', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/3Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/3Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/3Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/4Moz', 'VD1689_94', '4Moz', 'Ta zettorta Mohsus Grahmata', '1689', '1694', '17', 'GNP', FALSE, 4);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/4Moz', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/4Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/4Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/4Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/5Moz', 'VD1689_94', '5Moz', 'Ta peekta Mohsus Grahmata', '1689', '1694', '17', 'GNP', FALSE, 5);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/5Moz', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/5Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/5Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/5Moz', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Am', 'VD1689_94', 'Am', 'Tas Praweets Amos', '1689', '1694', '17', 'GNP', FALSE, 30);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Am', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Am', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Am', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Am', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Cef', 'VD1689_94', 'Cef', 'Tas Praweets Zewanijus', '1689', '1694', '17', 'GNP', FALSE, 36);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Cef', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Cef', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Cef', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Cef', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Dan', 'VD1689_94', 'Dan', 'Tas Praweets Danijels', '1689', '1694', '17', 'GNP', FALSE, 27);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Dan', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Dan', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Dan', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Dan', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Dz', 'VD1689_94', 'Dz', 'Salamaņa Augsta Dseesma', '1689', '1694', '17', 'GNP', FALSE, 22);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Dz', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Dz', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Dz', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Dz', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Ech', 'VD1689_94', 'Ech', 'Tas Praweets Ezekiels', '1689', '1694', '17', 'GNP', FALSE, 26);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Ech', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ech', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ech', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ech', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Est', 'VD1689_94', 'Est', 'Esteres Grahmata', '1689', '1694', '17', 'GNP', FALSE, 17);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Est', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Est', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Est', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Est', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Ezr', 'VD1689_94', 'Ezr', 'Esrus Grahmata', '1689', '1694', '17', 'GNP', FALSE, 15);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Ezr', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ezr', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ezr', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ezr', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Hab', 'VD1689_94', 'Hab', 'Tas Praweets Abakuks', '1689', '1694', '17', 'GNP', FALSE, 35);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Hab', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Hab', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Hab', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Hab', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Hag', 'VD1689_94', 'Hag', 'Tas Praweets Aggajus', '1689', '1694', '17', 'GNP', FALSE, 37);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Hag', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Hag', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Hag', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Hag', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Hoz', 'VD1689_94', 'Hoz', 'Tas Praweets Osejus', '1689', '1694', '17', 'GNP', FALSE, 28);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Hoz', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Hoz', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Hoz', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Hoz', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Ij', 'VD1689_94', 'Ij', 'Jjaba Grahmata', '1689', '1694', '17', 'GNP', FALSE, 18);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Ij', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ij', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ij', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ij', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Jer', 'VD1689_94', 'Jer', 'Tas Praweets Jeremijus', '1689', '1694', '17', 'GNP', FALSE, 24);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Jer', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Jer', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Jer', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Jer', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Jes', 'VD1689_94', 'Jes', 'Tas Praweets Esaijus', '1689', '1694', '17', 'GNP', FALSE, 23);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Jes', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Jes', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Jes', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Jes', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Jl', 'VD1689_94', 'Jl', 'Tas Praweets Joels', '1689', '1694', '17', 'GNP', FALSE, 29);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Jl', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Jl', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Jl', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Jl', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Jon', 'VD1689_94', 'Jon', 'Tas Prawwets Jonas', '1689', '1694', '17', 'GNP', FALSE, 32);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Jon', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Jon', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Jon', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Jon', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Joz', 'VD1689_94', 'Joz', 'Ta Josuus Grahmata', '1689', '1694', '17', 'GNP', FALSE, 6);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Joz', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Joz', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Joz', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Joz', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Mac', 'VD1689_94', 'Mac', 'Tas Mahzitais Salamans', '1689', '1694', '17', 'GNP', FALSE, 21);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Mac', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Mac', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Mac', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Mac', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Mal', 'VD1689_94', 'Mal', 'Tas Praweets Malakijus', '1689', '1694', '17', 'GNP', FALSE, 39);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Mal', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Mal', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Mal', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Mal', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Mih', 'VD1689_94', 'Mih', 'Tas Praweets Mikus', '1689', '1694', '17', 'GNP', FALSE, 33);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Mih', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Mih', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Mih', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Mih', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Nah', 'VD1689_94', 'Nah', 'Tas Praweets Nakums', '1689', '1694', '17', 'GNP', FALSE, 34);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Nah', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Nah', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Nah', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Nah', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Neh', 'VD1689_94', 'Neh', 'Neemijus Grahmata', '1689', '1694', '17', 'GNP', FALSE, 16);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Neh', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Neh', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Neh', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Neh', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Ob', 'VD1689_94', 'Ob', 'Tas Praweets Obadijus', '1689', '1694', '17', 'GNP', FALSE, 31);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Ob', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ob', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ob', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ob', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Prolog', 'VD1689_94', 'Prolog', '[Vecās Derības ievads]', '1689', '1694', '17', 'GLR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Prolog', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Prolog', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Prolog', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Prolog', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Ps', 'VD1689_94', 'Ps', 'Dahwida Dseesmu Grahmata', '1689', '1694', '17', 'GNP', FALSE, 19);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Ps', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ps', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ps', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Ps', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Rdz', 'VD1689_94', 'Rdz', 'Jeremijus Raudu=Dseesmas', '1689', '1694', '17', 'GNP', FALSE, 25);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Rdz', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Rdz', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Rdz', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Rdz', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Rut', 'VD1689_94', 'Rut', 'Ruttes Grahmata', '1689', '1694', '17', 'GNP', FALSE, 8);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Rut', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Rut', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Rut', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Rut', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Sak', 'VD1689_94', 'Sak', 'Salamaņa Sakkamee Wahrdi', '1689', '1694', '17', 'GNP', FALSE, 20);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Sak', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Sak', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Sak', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Sak', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Sog', 'VD1689_94', 'Sog', 'Ta Sohģu Grahmata', '1689', '1694', '17', 'GNP', FALSE, 7);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Sog', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Sog', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Sog', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Sog', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('Ernsts Gliks');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VD1689_94/Zah', 'VD1689_94', 'Zah', 'Tas Praweets Zakarijus', '1689', '1694', '17', 'GNP', FALSE, 38);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VD1689_94/Zah', (SELECT id FROM authors_new WHERE authors_new.name = 'Ernsts Gliks'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Zah', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Zah', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VD1689_94/Zah', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VLH1685', NULL, 'VLH1685', 'Vermehretes Lettisches Hand=buch', '1685', '1685', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VLH1685', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VLH1685', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VLH1685', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('katehisms', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VLH1685_Cat', NULL, 'VLH1685_Cat', 'Der kleine Catechismus, 1685', '1685', '1685', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VLH1685_Cat', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VLH1685_Cat', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VLH1685_Cat', (SELECT id FROM genres_new WHERE genres_new.name = 'katehisms'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Vecā Derība', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VLH1685_Sal', NULL, 'VLH1685_Sal', 'Die Sprüche Salomonis, 1685', '1685', '1685', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VLH1685_Sal', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VLH1685_Sal', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VLH1685_Sal', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VLH1685_Sal', (SELECT id FROM genres_new WHERE genres_new.name = 'Vecā Derība'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Garīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Bībele', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('apokrifi', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('VLH1685_Syr', NULL, 'VLH1685_Syr', 'Das Hauß=Zucht=und Lehr=Buch Jesus Syrach, 1685', '1685', '1685', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'VLH1685_Syr', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VLH1685_Syr', (SELECT id FROM genres_new WHERE genres_new.name = 'Garīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VLH1685_Syr', (SELECT id FROM genres_new WHERE genres_new.name = 'Bībele'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'VLH1685_Syr', (SELECT id FROM genres_new WHERE genres_new.name = 'apokrifi'));

INSERT IGNORE INTO authors_new (name) VALUES ('Mihaels Vitenburgs');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Witt1696_MMID', NULL, 'Witt1696_MMID', 'Man man ir Deews', '1696', '1696', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Witt1696_MMID', (SELECT id FROM authors_new WHERE authors_new.name = 'Mihaels Vitenburgs'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Witt1696_MMID', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Witt1696_MMID', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('Mihaels Vitenburgs');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Witt1702_PAN', NULL, 'Witt1702_PAN', 'Ta panesama Auna=Nasta apdohmata', '1702', '1702', '18', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Witt1702_PAN', (SELECT id FROM authors_new WHERE authors_new.name = 'Mihaels Vitenburgs'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Witt1702_PAN', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Witt1702_PAN', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('gadījuma dzeja', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('ZP1685', NULL, 'ZP1685', 'Semmiga Paklannischana', '1685', '1685', '17', 'LR', FALSE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'ZP1685', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'ZP1685', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'ZP1685', (SELECT id FROM genres_new WHERE genres_new.name = 'gadījuma dzeja'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lietišķie teksti', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('zvēresti', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Zv1638_VAR', NULL, 'Zv1638_VAR', '[Ziņu sniedzēja zvērests Vidzemes arklu revīzijā]', '1638', '1638', '17', 'LR', TRUE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Zv1638_VAR', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1638_VAR', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1638_VAR', (SELECT id FROM genres_new WHERE genres_new.name = 'lietišķie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1638_VAR', (SELECT id FROM genres_new WHERE genres_new.name = 'zvēresti'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lietišķie teksti', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('zvēresti', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Zv1681_Kok', NULL, 'Zv1681_Kok', '[Nevācu koku šķirotāju zvērests]', '1681', '1681', '17', 'LR', TRUE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Zv1681_Kok', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1681_Kok', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1681_Kok', (SELECT id FROM genres_new WHERE genres_new.name = 'lietišķie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1681_Kok', (SELECT id FROM genres_new WHERE genres_new.name = 'zvēresti'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lietišķie teksti', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('zvēresti', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Zv1681_Liec_1', NULL, 'Zv1681_Liec_1', '[Liecinieku zvērests, 1]', '1681', '1681', '17', 'LR', TRUE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Zv1681_Liec_1', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1681_Liec_1', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1681_Liec_1', (SELECT id FROM genres_new WHERE genres_new.name = 'lietišķie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1681_Liec_1', (SELECT id FROM genres_new WHERE genres_new.name = 'zvēresti'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lietišķie teksti', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('zvēresti', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Zv1681_Liec_2', NULL, 'Zv1681_Liec_2', '[Liecinieku zvērests, 2]', '1681', '1681', '17', 'LR', TRUE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Zv1681_Liec_2', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1681_Liec_2', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1681_Liec_2', (SELECT id FROM genres_new WHERE genres_new.name = 'lietišķie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1681_Liec_2', (SELECT id FROM genres_new WHERE genres_new.name = 'zvēresti'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lietišķie teksti', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('zvēresti', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Zv1689_Kan', NULL, 'Zv1689_Kan', '[Kaņepāju kulstītāju amata zvērests]', '1689', '1689', '17', 'LR', TRUE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Zv1689_Kan', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1689_Kan', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1689_Kan', (SELECT id FROM genres_new WHERE genres_new.name = 'lietišķie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1689_Kan', (SELECT id FROM genres_new WHERE genres_new.name = 'zvēresti'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lietišķie teksti', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('zvēresti', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Zv1689_Salsnes', NULL, 'Zv1689_Salsnes', '[Sālsnesēju amata zvērests]', '1689', '1689', '17', 'LR', TRUE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Zv1689_Salsnes', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1689_Salsnes', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1689_Salsnes', (SELECT id FROM genres_new WHERE genres_new.name = 'lietišķie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1689_Salsnes', (SELECT id FROM genres_new WHERE genres_new.name = 'zvēresti'));

INSERT IGNORE INTO authors_new (name) VALUES ('nezināms');
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('Laicīgie teksti', FALSE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('lietišķie teksti', TRUE);
INSERT IGNORE INTO genres_new (name, subgenre) VALUES ('zvēresti', TRUE);
INSERT INTO books_new (full_source, collection_code, item_code, name, year1, year2, pub_century, index_type, manuscript, order_in_collection)
  VALUES ('Zv1698_Lig', NULL, 'Zv1698_Lig', '[Liģeru amata zvērests]', '1698', '1698', '17', 'LR', TRUE, 0);
INSERT INTO books_authors_new (source, author_id, top_author)
  VALUES ( 'Zv1698_Lig', (SELECT id FROM authors_new WHERE authors_new.name = 'nezināms'), TRUE);
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1698_Lig', (SELECT id FROM genres_new WHERE genres_new.name = 'Laicīgie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1698_Lig', (SELECT id FROM genres_new WHERE genres_new.name = 'lietišķie teksti'));
INSERT INTO books_genres_new (source, genre_id)
  VALUES ( 'Zv1698_Lig', (SELECT id FROM genres_new WHERE genres_new.name = 'zvēresti'));

