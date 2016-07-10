CREATE TABLE words (
  rnd SMALLINT UNSIGNED NOT NULL,
  word CHAR(30) NOT NULL,
  sense CHAR(50) NOT NULL,
  context CHAR(100) NOT NULL,
  PRIMARY KEY (rnd),
  UNIQUE (word)
);