-- Week 5 - Wednesday
-- Questions

-- 1. List all customers who live in Texas (use
-- JOINs)

SELECT CONCAT(customer.first_name, ' ' , customer.last_name) as full_name,
customer.email, address.district
FROM customer
JOIN address
ON address.address_id = customer.address_id
WHERE address.district = 'Texas';

--Answer: 5 customers live in texas



-- 2. Get all payments above $6.99 with the Customer's Full
-- Name
SELECT CONCAT(customer.first_name, ' ' , customer.last_name) as full_name,
payment.amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount > 6.99;

--Answer: this one is pretty straight forward
-- 3. Show all customers names who have made payments over $175(use
-- subqueries)

SELECT CONCAT(customer.first_name, ' ' , customer.last_name) as full_name,
payment.amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment_id IN (
SELECT payment_id
FROM payment
WHERE amount > 175.00
);

--There are no payments above $175, the highest payment is 124
-- unless of course you wanted to do TOTAL payments then you could do this:


SELECT CONCAT(customer.first_name, ' ', customer.last_name) as full_name
FROM customer
WHERE customer_id in(
        SELECT customer_id
        FROM payment
        GROUP BY customer_id
        HAVING SUM(amount) > 175
    );
--if I could use a join I could get the amount for you
--this shows all the names of customers who spent over $175.00


-- 4. List all customers that live in Nepal (use the city
-- table)
SELECT first_name, last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

-- Answer: only one customer live is Nepal, Kevin Schuler

-- 5. Which staff member had the most
-- transactions?
SELECT first_name, staff.staff_id, COUNT(payment_id)
FROM staff
INNER JOIN payment
ON payment.staff_id = staff.staff_id
GROUP BY first_name, staff.staff_id
ORDER BY COUNT(payment_id) DESC;

--Answer: Jon has the most transactions, with a small lead of 12, so they are neck and neck.

-- 6. How many movies of each rating are
-- there?
SELECT *
FROM (
    SELECT COUNT(rating) as cnt_rate, rating
    FROM film
    GROUP BY rating

    
    
    )as cnts;
-- Answer: well we did this one in class haha thanks kevin!
-- 7.Show all customers who have made a single payment
-- above $6.99 (Use Subqueries)
SELECT CONCAT(customer.first_name, ' ', customer.last_name) as full_name
FROM customer
WHERE customer_id IN (
	SELECT customer_id 
	FROM payment
	WHERE amount > 6.99
);

--Answer: well its the same as above this is just doing it with subqueries.

-- 8. How many free rentals did our stores give away?

SELECT COUNT(amount)
FROM payment
WHERE amount = 0;

--Answer: this is very funny because I did this on monday just for
--Fun because I was curious so I added some complexity to it

SELECT CONCAT(staff.first_name, ' ', staff.last_name) as full_name, COUNT(amount)
FROM staff
JOIN payment
ON payment.staff_id = staff.staff_id
WHERE amount = 0.00
GROUP BY staff.staff_id
ORDER BY COUNT(amount);

--Mike has given away 15 items... wonder what he is up too..


