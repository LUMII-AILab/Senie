CREATE TABLE quotes (
  rnd SMALLINT UNSIGNED NOT NULL,
  text CHAR(50) NOT NULL,
  context CHAR(100) NOT NULL,
  PRIMARY KEY (rnd),
  UNIQUE (text)
);