CREATE TABLE coopers (
  author TINYINT UNSIGNED NOT NULL,
  source SMALLINT UNSIGNED NOT NULL,
  UNIQUE (author, source)
);