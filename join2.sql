
CREATE TABLE Artists (
  artist_id INTEGER PRIMARY KEY,
  artist_name varchar(50) NOT NULL
);
CREATE TABLE Albums (
  album_id INTEGER PRIMARY KEY,
  album_name varchar(50) NOT NULL,
  artist_id INTEGER NOT NULL,
  FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);

INSERT INTO Artists (artist_id, artist_name) VALUES
  (1, 'The Beatles'),
  (2, 'Led Zeppelin'),
  (3, 'Pink Floyd');
INSERT INTO Albums (album_id, album_name, artist_id) VALUES
  (1, 'Abbey Road', 1),
  (2, 'Led Zeppelin IV', 2),
  (3, 'Dark Side of the Moon', 3),
  (4, 'The Wall', 3),
  (5, 'Houses of the Holy', 2),
  (6, 'Let It Be', 1);

  --1. Write a SQL query to retrieve the names of all albums and their corresponding artist names using an inner join.
  SELECT album_name,artist_name from Artists ar
  inner join Albums al on ( ar.artist_id = al.artist_id)
  --2. Write a SQL query to retrieve the names of all artists and the names of any albums they have recorded, even if they have not yet recorded an album, using a left join.
    SELECT artist_name,album_name from Artists ar
  left join Albums al on ( ar.artist_id = al.artist_id)
  --3. Write a SQL query to retrieve the names of all albums and the names of any artists who have recorded them, even if no albums have been recorded, using a right join.
    SELECT album_name,artist_name from Artists ar
  right join Albums al on ( ar.artist_id = al.artist_id)
  --4. Write a SQL query to retrieve the names of all artists and the names of any albums they have recorded, including cases where there are no matching records in either table, using a full join.
      SELECT album_name,artist_name from Artists ar
  full join Albums al on ( ar.artist_id = al.artist_id)