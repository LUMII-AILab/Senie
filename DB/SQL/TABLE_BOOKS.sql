CREATE TABLE books (
  id TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  source SMALLINT UNSIGNED NOT NULL,
  codificator CHAR(15) NOT NULL,
  name CHAR(100) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (codificator)
);