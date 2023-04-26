use Sakila;
show tables;
#Get release years.
SELECT release_year FROM FILM;

#Get all films with ARMAGEDDON in the title.
SELECT title FROM FILM
WHERE title like '%ARMAGEDDON%';

#Get all films which title ends with APOLLO.
SELECT title FROM FILM
WHERE title like '%APOLLO';

#Get 10 the longest films.
SELECT * FROM film
order by length DESC
LIMIT 10;

#How many films include Behind the Scenes content?
SELECT COUNT(title) FROM film
where special_features like '%Behind%';

#Drop column picture from staff.
ALTER TABLE staff
DROP COLUMN picture;

#A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
#select * FROM customer
insert into customer
values (600,2,'TAMMY','SANDERS','tammytam@k.com',3,1,now(),now());
select * FROM customer;
DELETE FROM customer
WHERE customer_id = 600;
select * FROM staff;
insert into staff 
values (3,'TAMMY','SANDERS', null, null, null, null, null, null, null);
#Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (NOW(), (SELECT inventory_id FROM inventory WHERE film_id = (SELECT film_id FROM film WHERE title = 'Academy Dinosaur') AND store_id = 1 LIMIT 1), 
(SELECT customer_id FROM customer WHERE first_name = 'CHARLOTTE' AND last_name = 'HUNTER'), 1);

#Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
CREATE TABLE deleted_users AS
SELECT customer_id, email, NOW() FROM customer
WHERE active = 0;

DELETE FROM customer
WHERE active = 0;

SELECT * FROM deleted_users