--JOINS
-- 1.
SELECT * 
FROM invoice
JOIN invoice_line 
ON invoice_line.invoice_id = invoice.invoice_id
WHERE invoice_line.unit_price > 0.99;
-- 2.
SELECT invoice.invoice_date, customer.first_name, customer.last_name, invoice.total 
FROM invoice
JOIN customer 
ON customer.customer_id = invoice.customer_id;
-- 3.
SELECT customer.first_name, customer.last_name, employee.first_name, employee.last_name
FROM customer
JOIN employee 
ON customer.support_rep_id = employee.employee_id;
-- 4.
SELECT album.title, artist.name 
FROM album
JOIN artist 
ON album.artist_id = artist.artist_id;
-- 5.
SELECT playlist_track.track_id
FROM playlist_track
JOIN playlist  
ON playlist_track.playlist_id = playlist.playlist_id
WHERE playlist.name = 'Music';
-- 6.
SELECT track.name 
FROM track
JOIN playlist_track 
ON track.track_id = playlist_track.track_id
WHERE playlist_track.playlist_id = 5;
-- 7.
SELECT track.name, playlist.name
FROM track
JOIN playlist_track 
ON track.track_id = playlist_track.track_id
JOIN playlist 
ON playlist.playlist_id = playlist_track.playlist_id;
-- 8.
SELECT track.name, album.title
FROM track
JOIN genre ON track.genre_id = genre.genre_id
JOIN album ON track.album_id = album.album_id
WHERE genre.name = 'Alternative & Punk'
--Black Diamond
SELECT track.name, genre.name, album.title, artist.name
FROM track
JOIN genre ON track.genre_id = genre.genre_id
JOIN album ON track.album_id = album.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN playlist_track ON playlist_track.track_id = track.track_id
JOIN playlist ON playlist.playlist_id = playlist_track.playlist_id
WHERE playlist.name = 'Music'

-- NESTED QUERIES
--1.
SELECT * FROM invoice
WHERE invoice_id IN
(SELECT invoice_id FROM invoice_line
WHERE unit_price > 0.99);
-- 2.
SELECT * FROM playlist_track
WHERE playlist_id IN
(SELECT playlist_id FROM playlist
WHERE name = 'Music');
-- 3.
SELECT name FROM track
WHERE track_id IN
(SELECT track_id FROM playlist_track
WHERE playlist_id = 5);
-- 4.
SELECT * FROM track
WHERE genre_id IN
(SELECT genre_id FROM genre
WHERE name = 'Comedy');
-- 5.
SELECT * FROM track
WHERE album_id IN
(SELECT album_id FROM album
WHERE title = 'Fireball');
-- 6.
SELECT * FROM track
WHERE album_id IN
(SELECT album_id FROM album
 WHERE artist_id IN
 (SELECT artist_id FROM artist
  WHERE name = 'Queen');

-- UPDATING ROWS
-- 1.
UPDATE customer
SET fax = null
WHERE fax IS NOT null;
-- 2.
UPDATE customer
SET company = 'Self'
WHERE company IS null;
-- 3.
UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';
-- 4.
UPDATE customer
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';
-- 5.
UPDATE track
SET composer = 'The darness around us'
WHERE genre_id = (SELECT genre_id FROM genre WHERE name = 'Metal')
AND composer IS null;

-- GROUP BY
-- 1.
SELECT COUNT(*), genre.name FROM track
JOIN genre ON track.genre_id = genre.genre_id
GROUP BY genre.name;
--2.
SELECT COUNT(*), genre.name FROM track
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name = 'Pop' AND genre.name = 'Rock'
GROUP BY genre.name;
-- 3.
SELECT artist.name, COUNT(*) FROM album
JOIN artist ON artist.artist_id = album.artist_id
GROUP BY artist.name;
-- USE DISTINCT
-- 1.
SELECT DISTINCT composer 
FROM track;
-- 2.
SELECT DISTINCT billing_postal_code
FROM invoice;
-- 3.
SELECT DISTINCT company
FROM customer;

-- DELETE ROWS
-- 1.
DELETE FROM practice_delete
WHERE type = 'bronze';
-- 2.
DELETE FROM practice_delete
WHERE type = 'silver';
-- 3.
DELETE FROM practice_delete
WHERE value = 150;

-- eCOMMERCE SIMULATION
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(150)
);
CREATE TABLE products (
  product_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  price NUMERIC
);
CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  product_id INTEGER REFERENCES products(product_id),
  quantity INTEGER
);

INSERT INTO users (name, email)
VALUES ('Jose', 'jose@jose.com'), ('Raul', 'raul@raul.com'), ('Andrew', 'andrew@andrew.com');

INSERT INTO products (name, price)
VALUES ('watch', 500), ('ring', 1000), ('bracelet', 1500);

INSERT INTO orders (order_id, product_id, quantity)
VALUES (1,1,1), (2, 2, 2), (3, 3, 3);

select * from orders
where order_id = 1;

SELECT * FROM orders;

SELECT products.price*orders.quantity FROM orders
JOIN products ON products.product_id = orders.product_id
WHERE order_id = 2;

ALTER TABLE orders
ADD COLUMN user_id INTEGER REFERENCES users(user_id);

update orders
set user_id = 1
where order_id = 1;

update orders
set user_id = 2
where order_id = 2;

update orders
set user_id = 3
where order_id = 3;

select SUM(*) from orders
where user_id = 1;

select COUNT(*) from orders
where user_id = 1;
