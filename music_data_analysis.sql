/*
Project Name: Music Data Analysis for Beginners
Developed by Golam Kaderye
*/

-- QUERIES (SET-1: EASY):

/*
    QUERY-1: Who is the senior most employee based on job title? 
*/
-- check music_employee table details
SELECT
    * FROM music_employee;
    
-- solution of query - 1
SELECT employee_id, first_name||' '||last_name "Full Name", title, levels
FROM music_employee
ORDER BY levels DESC
FETCH FIRST 1 ROW ONLY;

-- ===========================================================================

/*
    QUERY-2: Find the list of youngest employees based on job title? 
*/
-- check music_employee table details
SELECT
    * FROM music_employee;
    
-- solution of query - 2
SELECT employee_id, first_name||' '||last_name "Full Name", title, levels
FROM music_employee
ORDER BY levels;

-- ===========================================================================
/*
    QUERY-3: Find the details that have lived in Lethargies. 
*/
-- check music_employee table details
SELECT
    * FROM music_employee;
    
-- solution of query - 3
SELECT *
FROM music_employee
WHERE city = 'Lethbridge';

-- ===========================================================================
/*
    Query-4: Which countries have the most invoices? 
*/
-- check music_invoice table details
SELECT
    * FROM music_invoice;
    
-- solution of query - 4
SELECT billing_country, COUNT(*)
FROM music_invoice
GROUP BY billing_country
ORDER BY COUNT(*) DESC;

-- ===========================================================================
/*
    Query-5: What are the top three values of total invoice? 
*/
-- check music_invoice table details
SELECT
    * FROM music_invoice;
    
-- solution of query - 5
SELECT total
FROM music_invoice
ORDER BY total DESC
FETCH FIRST 3 ROWS ONLY;

-- ===========================================================================
/*
    Query-6: Which city has the best customers? We would like to throw a 
    promotional music festival in the city where we made the most money. 
    Write a SQL query that returns one city that has the highest sum of 
    invoice totals. Return both the city name and sum of all invoice totals.
*/
-- check music_invoice table details
SELECT
    * FROM music_invoice;
    
-- solution of query - 6
SELECT billing_city, SUM(total) "Total Invoice"
FROM music_invoice
GROUP BY billing_city
ORDER BY "Total Invoice" DESC
FETCH FIRST 1 ROW ONLY;

-- ===========================================================================
/*
    Query-7: Who is the best customer? The customer who has spent the most 
    money will be declared the best customer. Write a SQL query that returns 
    the person who has spent the most money.
*/
-- check music_customer table details
SELECT
    * FROM music_customer;
    
-- check music_invoice table details
SELECT
    * FROM music_invoice;
    
-- Frist way: solution of query - 7
SELECT mc.customer_id, mc.first_name || ' ' || mc.last_name AS "Full Name",
SUM(mi.total) AS "Total Invoice"
FROM music_customer mc
JOIN music_invoice mi
ON mc.customer_id = mi.customer_id
GROUP BY mc.customer_id, mc.first_name, mc.last_name
ORDER BY SUM(mi.total) DESC
FETCH FIRST 1 ROW ONLY;

-- Second way: solution of query - 7
SELECT mc.customer_id, mc.first_name || ' ' || mc.last_name AS "Full Name",
SUM(mi.total) AS "Total Invoice"
FROM music_customer mc, music_invoice mi
WHERE mc.customer_id = mi.customer_id
GROUP BY mc.customer_id, mc.first_name, mc.last_name
ORDER BY SUM(mi.total) DESC
FETCH FIRST 1 ROW ONLY;

-- ===========================================================================
/*
    Query-8: Find the last 5 customers? The customer who has spent the least
    money will be declared the last customer. Write a SQL query that returns 
    the person who has spent the least money with the city name also.
*/
-- check music_customer table details
SELECT
    * FROM music_customer;
    
-- check music_invoice table details
SELECT
    * FROM music_invoice;
    
-- Frist way: solution of query - 8
SELECT mc.customer_id, mc.first_name || ' ' || mc.last_name AS "Full Name",
mc.city, SUM(mi.total) AS "Total Invoice"
FROM music_customer mc
JOIN music_invoice mi
ON mc.customer_id = mi.customer_id
GROUP BY mc.customer_id, mc.first_name, mc.last_name, mc.city
ORDER BY SUM(mi.total) ASC
FETCH FIRST 5 ROWS ONLY;

-- Second way: solution of query - 8
SELECT mc.customer_id, mc.first_name || ' ' || mc.last_name AS "Full Name",
mc.city, SUM(mi.total) AS "Total Invoice"
FROM music_customer mc, music_invoice mi
WHERE mc.customer_id = mi.customer_id
GROUP BY mc.customer_id, mc.first_name, mc.last_name, mc.city
ORDER BY SUM(mi.total) ASC
FETCH FIRST 5 ROWS ONLY;

-- ===========================================================================
/*
    Query-9: Find the list of customers id, customers full name, billing city 
    and billing country with the total invoice is greater than 100.
*/
-- check music_customer table details
SELECT
    * FROM music_customer;
    
-- check music_invoice table details
SELECT
    * FROM music_invoice;
    
-- Frist way: solution of query - 9
SELECT mc.customer_id, mc.first_name || ' ' || mc.last_name AS "Full Name",
mi.billing_city, mi.billing_country, SUM(mi.total) AS "Total Invoice"
FROM music_customer mc
JOIN music_invoice mi
ON mc.customer_id = mi.customer_id
GROUP BY mc.customer_id, mc.first_name, mc.last_name, mc.city,
mi.billing_city,mi.billing_country
HAVING SUM(mi.total) > 100;


-- Second way: solution of query - 9
SELECT mc.customer_id, mc.first_name || ' ' || mc.last_name AS "Full Name",
mi.billing_city, mi.billing_country, SUM(mi.total) AS "Total Invoice"
FROM music_customer mc, music_invoice mi
WHERE mc.customer_id = mi.customer_id
GROUP BY mc.customer_id, mc.first_name, mc.last_name, mc.city,
mi.billing_city,mi.billing_country
HAVING SUM(mi.total) > 100;

-- ===========================================================================
/*
    Query-10: Calculate the total invoice based on the billing city.
*/
-- check music_invoice table details
SELECT
    * FROM music_invoice;
    
-- solution of query - 10
SELECT billing_city, SUM(total)
FROM music_invoice
GROUP BY billing_city
ORDER BY SUM(total) DESC;


-- ===========================================================================


-- QUERIES (SET-2: INTERMEDIATE):


/*
    Query-11: Write a SQL query to return the email, first name, last name and 
    genre of all 'Rock' music listeners. Return your list ordered alphabetically 
    by email starting with A.
*/
-- check music_customer table details
SELECT
    * FROM music_customer;
-- check music_invoice table details
SELECT
    * FROM music_invoice;
-- check music_invoice_line table details
SELECT
    * FROM music_invoice_line;
-- check music_track table details
SELECT
    * FROM music_track;
-- check music_genre table details
SELECT
    * FROM music_genre;
    
-- First way: solution of query - 11
SELECT DISTINCT music_customer.email, music_customer.first_name,
music_customer.last_name,music_genre.name
FROM music_customer
JOIN music_invoice ON music_customer.customer_id=music_invoice.customer_id
JOIN music_invoice_line ON music_invoice.invoice_id=music_invoice_line.invoice_id
JOIN music_track ON music_invoice_line.track_id=music_track.track_id
JOIN music_genre ON music_track.genre_id=music_genre.genre_id
WHERE music_genre.name LIKE 'Rock'
ORDER BY music_customer.email;

-- Second way: solution of query - 11
SELECT DISTINCT music_customer.email, music_customer.first_name,
music_customer.last_name
FROM music_customer
JOIN music_invoice ON music_customer.customer_id=music_invoice.customer_id
JOIN music_invoice_line ON music_invoice.invoice_id=music_invoice_line.invoice_id
WHERE track_id IN(
    SELECT track_id FROM music_track
    JOIN music_genre ON music_track.genre_id=music_genre.genre_id
    WHERE music_genre.name LIKE 'Rock'
)
ORDER BY music_customer.email;


-- ===========================================================================
/*
    Query-12: Let’s invite the artists who have written the most rock music in 
    our dataset. Write a SQL query that returns the artist name 
    and total track count of the top 10 rock bands.
*/
-- check music_artist table details
SELECT
    * FROM music_artist;
-- check music_album table details
SELECT
    * FROM music_album;
-- check music_track table details
SELECT
    * FROM music_track;
-- check music_genre table details
SELECT
    * FROM music_genre;
    
-- solution of query - 12
SELECT music_artist.artist_id, music_artist.name, 
COUNT(music_track.genre_id) "Nmber of Total Track"
FROM music_artist
JOIN music_album ON music_artist.artist_id = music_album.artist_id
JOIN music_track ON music_album.album_id=music_track.album_id
JOIN music_genre ON music_track.genre_id=music_genre.genre_id
WHERE music_genre.name LIKE 'Rock'
GROUP BY music_artist.artist_id, music_artist.name
ORDER BY "Nmber of Total Track" DESC
FETCH FIRST 10 ROWS ONLY;

-- ===========================================================================
/*
    Query-13: Return all the track names that have a song length longer than 
    the average song length. Return the name and milliseconds for each track, 
    ordered by the song length with the longest songs listed first.
*/
-- check music_track table details
SELECT
    * FROM music_track;
    
-- calulate the average milliseconds
SELECT AVG(milliseconds)
FROM music_track;
-- check the track name where the milliseconds is greater than average milliseconds
SELECT name, milliseconds
FROM music_track
WHERE milliseconds > 394540.3111686816350028785261945883707542
ORDER BY milliseconds DESC;

    
-- The best way: solution of query - 13
SELECT track_id, name, milliseconds
FROM music_track
WHERE milliseconds > (SELECT AVG(milliseconds) "Average" FROM music_track)
ORDER BY milliseconds DESC;

-- ===========================================================================

/*
    Query-14: Write a SQL query to return all the track ids, track names, 
    milliseconds and percentage for each track, 
    ordered by the highest percentage.
*/
-- check music_track table details
SELECT
    * FROM music_track;

-- solution of query-14
SELECT track_id, name, milliseconds,
(milliseconds*100/(SELECT SUM(milliseconds) FROM music_track)) "Percentage"
FROM music_track
GROUP BY track_id, name, milliseconds
ORDER BY "Percentage" DESC;

-- ===========================================================================

-- QUERIES (SET-3: ADVANCED):

/*
    Query-15: Find how much amount spent by each customer on artists? 
    Write a SQL query to return customer name, artist name and total spent.
*/
-- check music_invoice_line table details
SELECT
    * FROM music_invoice_line;
-- check music_track table details
SELECT
    * FROM music_track;
-- check music_album table details
SELECT
    * FROM music_album;
-- check music_artistt table details
SELECT
    * FROM music_artist;
-- check music_invoice table details
SELECT
    * FROM music_invoice;
-- check music_customer table details
SELECT
    * FROM music_customer;

-- solution of query-15
WITH best_selling_artist AS(
SELECT ma.artist_id "Artist ID", ma.name "Artist Name",
SUM(mil.unit_price*mil.quantity) "Total Sales"
FROM music_invoice_line mil
JOIN music_track mt ON mil.track_id=mt.track_id
JOIN music_album mal ON mal.album_id=mt.album_id
JOIN music_artist ma ON ma.artist_id = mal.artist_id
GROUP BY ma.artist_id, ma.name
ORDER BY "Total Sales" DESC
FETCH FIRST 1 ROW ONLY
)

SELECT mc.customer_id,mc.first_name,mc.last_name,bsa."Artist Name",
SUM(mil.unit_price*mil.quantity) "Ammount Spent"
FROM music_invoice mi
JOIN music_customer mc ON mc.customer_id=mi.customer_id
JOIN music_invoice_line mil ON mil.invoice_id=mi.invoice_id
JOIN music_track mt ON mt.track_id=mil.track_id
JOIN music_album mal ON mal.album_id=mt.album_id
JOIN best_selling_artist bsa ON bsa."Artist ID"=mal.artist_id
GROUP BY mc.customer_id,mc.first_name,mc.last_name,bsa."Artist Name"
ORDER BY "Ammount Spent" DESC;


-- ===========================================================================

/*
    Query-16: We want to find out the most popular music genre for each 
    country. We determine the most popular genre as the genre with the 
    highest amount of purchases. Write a SQL query that returns each country 
    along with the top genre. For countries where the maximum number of 
    purchases is shared, return all genres.
*/
-- check music_genre table details
SELECT *FROM music_genre;
-- check music_track table details
SELECT *FROM music_track;
-- check music_invoice_line table details
SELECT *FROM music_invoice_line;
-- check music_invoice details
SELECT *FROM music_invoice;
-- check music_customer details
SELECT *FROM music_customer;

-- first way: solution of query-16
WITH sales_per_country AS(
SELECT COUNT(mil.quantity) purchases_per_genre, 
mc.country, mg.name, mg.genre_id
FROM music_invoice_line mil
JOIN music_invoice mi ON mi.invoice_id=mil.invoice_id
JOIN music_customer mc ON mc.customer_id=mi.customer_id
JOIN music_track mt ON mt.track_id=mil.track_id
JOIN music_genre mg ON mg.genre_id=mt.genre_id
GROUP BY mc.country, mg.name, mg.genre_id
ORDER BY mc.country
),
max_genre_per_country AS(SELECT MAX(purchases_per_genre) AS max_genre_number,
country
FROM sales_per_country
GROUP BY country
ORDER BY country)

SELECT spc.*
FROM sales_per_country spc
JOIN max_genre_per_country mgpc ON spc.country=mgpc.country
WHERE spc.purchases_per_genre = mgpc.max_genre_number;


-- second way: solution of query-16
WITH sales_per_country AS(
SELECT COUNT(mil.quantity) purchases_per_genre, 
mc.country, mg.name, mg.genre_id,
ROW_NUMBER() OVER(PARTITION BY mc.country ORDER BY COUNT(mil.quantity)DESC)
AS RowNo
FROM music_invoice_line mil
JOIN music_invoice mi ON mi.invoice_id=mil.invoice_id
JOIN music_customer mc ON mc.customer_id=mi.customer_id
JOIN music_track mt ON mt.track_id=mil.track_id
JOIN music_genre mg ON mg.genre_id=mt.genre_id
GROUP BY mc.country, mg.name, mg.genre_id
ORDER BY mc.country
)
SELECT *FROM sales_per_country 
WHERE RowNo=1;

-- ===========================================================================

/*
    Query-17: Write a SQL query that determines the customer that has spent 
    the most on music for each country. Write a SQL query that returns the 
    country along with the top customer and how much they spent. 
    For countries where the top amount spent is shared, 
    provide all customers who spent this amount.
*/
-- check music_customer details
SELECT *FROM music_customer;
-- check music_invoice details
SELECT *FROM music_invoice;


-- first way: solution of query-16
WITH spent_per_country AS(
SELECT SUM(mi.total) spent_per_customer, 
mc.country, mc.first_name||' '||mc.last_name "Full Name", mc.customer_id,
ROW_NUMBER() OVER(PARTITION BY mc.country ORDER BY MAX(mi.total) DESC)
AS RowNo
FROM music_invoice mi
JOIN music_customer mc ON mc.customer_id=mi.customer_id
GROUP BY mc.country, mc.first_name, mc.last_name, mc.customer_id
ORDER BY mc.country
)
SELECT *FROM spent_per_country
WHERE RowNo=1;

-- ===========================================================================


-- QUERIES (SET-4: MIXED):


/*
    Query-18: What are the most popular genres of music? 
*/
-- check music_genre table details
SELECT *FROM music_genre;
-- check music_track table details
SELECT *FROM music_track;
-- check music_invoice_line table details
SELECT *FROM music_invoice_line;
    
-- solution of query - 18
SELECT mg.name, COUNT(mil.quantity)
FROM music_genre mg
JOIN music_track mt ON mt.genre_id=mg.genre_id
JOIN music_invoice_line mil ON mil.track_id=mt.track_id
GROUP BY mg.name
ORDER BY 2 DESC
FETCH FIRST 1 ROW ONLY;

-- ===========================================================================

/*
    Query-19: What are the 5 most popular artists? 
*/
-- check music_artist table details
SELECT *FROM music_artist;
-- check music_album table details
SELECT *FROM music_album;
-- check music_track table details
SELECT *FROM music_track;
-- check music_invoice_line table details
SELECT *FROM music_invoice_line;
    
-- solution of query - 19
SELECT ma.name, COUNT(mil.quantity)
FROM music_artist ma
JOIN music_album mal ON mal.artist_id=ma.artist_id
JOIN music_track mt ON mt.album_id=mal.album_id
JOIN music_invoice_line mil ON mil.track_id=mt.track_id
GROUP BY ma.name
ORDER BY 2 DESC
FETCH FIRST 5 ROWS ONLY;

-- ===========================================================================


/*
    Query-20: What are the 5 most popular songs? 
*/

-- check music_track table details
SELECT *FROM music_track;
-- check music_invoice_line table details
SELECT *FROM music_invoice_line;
    
-- solution of query - 20
SELECT mt.name "Song Names", COUNT(mil.quantity)
FROM music_invoice_line mil
JOIN music_track mt ON mt.track_id=mil.track_id
GROUP BY mt.name
ORDER BY COUNT(mil.quantity) DESC
FETCH FIRST 5 ROWS ONLY;

-- ===========================================================================


/*
    Query-21: What are the average prices of different types of music?  
*/

-- check music_genre table details
SELECT *FROM music_genre;
-- check music_track table details
SELECT *FROM music_track;
-- check music_invoice_line table details
SELECT *FROM music_invoice_line;
-- check music_invoice table details
SELECT *FROM music_invoice;
    
-- solution of query - 21
SELECT mg.name "Music Names", ROUND(AVG(mi.total),3)  "Average Prices"
FROM music_genre mg
JOIN music_track mt ON mt.genre_id=mg.genre_id
JOIN music_invoice_line mil ON mil.track_id=mt.track_id
JOIN music_invoice mi ON mi.invoice_id=mil.invoice_id
GROUP BY mg.name
ORDER BY "Average Prices" DESC;

-- ===========================================================================


/*
    Query-22: What are the most popular countries for music purchases?  
*/

-- check music_cusotmer table details
SELECT *FROM music_customer;
-- check music_invoice table details
SELECT *FROM music_invoice;
-- check music_invoice_line table details
SELECT *FROM music_invoice_line;
    
-- solution of query - 22
SELECT mc.country "Country Names", COUNT(mil.quantity) purchases
FROM music_invoice_line mil
JOIN music_invoice mi ON mi.invoice_id=mil.invoice_id
JOIN music_customer mc ON mc.customer_id=mi.customer_id
GROUP BY mc.country
ORDER BY purchases DESC;

-- ===========================================================================
-- ++++++++++++++++++++++++ THE END +++++++++++++++++++++++++++++++++++++++
-- ===========================================================================
