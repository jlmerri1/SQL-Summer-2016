/*
1. What is the name, phone numbeR, balance due and 
number of days outstanding of anyone that has an 
outstanding balance
*/

SELECT v.*, t.phone
FROM past_due_ninety_less v JOIN client t
    ON v.first_name = t.first_name
UNION ALL
SELECT v.*, t.phone
FROM past_due_ninety_more v JOIN client t
    ON v.first_name = t.first_name;
/*
Result:
Jane	Lane	 $225.00	66	847-555-3245
Tom	Sloane	 $360.00	194	224-555-9010
*/


/*
2. In order to expand the correct services what is the total sum of 
each service item beginning st the start of this fiscal year, 2/1/2016?
*/

SELECT service_desc, COUNT(*) AS "Number of service items", 
      TO_CHAR(SUM(service_cost), '$999.99') AS sum 
FROM service_items
WHERE service_desc LIKE '%boarding%'
      AND service_date > '1-FEB-2016'
GROUP BY service_desc
UNION
SELECT service_desc, COUNT(*) AS "Number of service items", 
      TO_CHAR(SUM(service_cost), '$999.99') AS "Sum"
FROM service_items
WHERE service_desc LIKE '%bath%'
      AND service_date > '1-FEB-2016'
GROUP BY service_desc
UNION
SELECT service_desc, COUNT(*) AS "Number of service items", 
      TO_CHAR(SUM(service_cost), '$999.99') AS sum 
FROM service_items
WHERE service_desc LIKE '%nail%'
      AND service_date > '1-FEB-2016'
GROUP BY service_desc
UNION
SELECT service_desc, COUNT(*) AS "Number of service items", 
      TO_CHAR(SUM(service_cost), '$999.99') AS "Sum"
FROM service_items
WHERE service_desc LIKE '%teeth%'
      AND service_date > '1-FEB-2016'
GROUP BY service_desc
ORDER BY sum;
/*
Result:
teeth cleaning	4	  $40.00
nail trimming	4	  $60.00
one night boarding	2	  $90.00
bath	6	 $120.00
four nights boarding	2	 $360.00
seven nights boarding	2	 $630.00
nine nights boarding	3	########
*/


/*
3. How much moneny has a client spent this fiscal year? 
Label who has paid and who is past due.
*/
SELECT 'Paid' AS Payment, first_name || ' ' || last_name as "Name", TO_CHAR(SUM(service_total), '$999.99') AS "Total"
FROM client c JOIN animal a
    USING(client_id)
    JOIN services
    USING(animal_id)
WHERE depart_date < SYSDATE AND
      service_total - payment_total - refund_total = 0
GROUP BY first_name || ' ' || last_name
UNION
SELECT 'Past Due' AS Payment, first_name || ' ' || last_name as "Name", TO_CHAR(SUM(service_total), '$999.99') AS "Total"
FROM client c JOIN animal a
    USING(client_id)
    JOIN services
    USING(animal_id)
WHERE depart_date < SYSDATE AND
      service_total - payment_total - refund_total > 0
GROUP BY first_name || ' ' || last_name
ORDER BY "Total";
/*
Result:
Paid	Daria Morgendorffer	  $65.00
Paid	Tiffany Blum-Deckler	  $65.00
Paid	Patsy Stone	 $225.00
Past Due	Jane Lane	 $225.00
Past Due	Tom Sloane	 $360.00
*/


/*
4. 5% interest will be added to the balance of any unpaid service total ever
90 days it is outstanding.  Display these accounts then update the service total
to reflect the new amount owed, then display the new total.
*/
SELECT 'Under 90' AS "Number of Days", v.*, t.phone 
FROM past_due_ninety_less v JOIN client t
    ON v.first_name = t.first_name
UNION ALL
SELECT 'Over 90' as "Number of Days", v.*, t.phone
FROM past_due_ninety_more v JOIN client t
    ON v.first_name = t.first_name;
    
UPDATE services
SET service_total = service_total + (service_total * .05)
WHERE animal_id IN
    (Select animal_id
    FROM animal
    WHERE sysdate - depart_date > 90
    AND service_total - payment_total - refund_total > 0 );

SELECT 'Under 90' AS "Number of Days", v.*, t.phone 
FROM past_due_ninety_less v JOIN client t
    ON v.first_name = t.first_name
UNION ALL
SELECT 'Over 90' as "Number of Days", v.*, t.phone
FROM past_due_ninety_more v JOIN client t
    ON v.first_name = t.first_name;
    
ROLLBACK;
/*
Result:
BEFORE UPDATE:
Under 90	Jane	Lane	 $225.00	66	847-555-3245
Over 90	Tom	Sloane	 $360.00	194	224-555-9010

AFTER UPDATE:
Under 90	Jane	Lane	 $225.00	66	847-555-3245
Over 90	Tom	Sloane	 $378.00	194	224-555-9010
*/


/*
5. Management is toying with the idea of adding a frequent client program where
clients recieve discounts for every four (4) times they've visited and signed 
theirdog up for services.  To be clear, promotion is for each visit, per dog, 
not the number of service items.
*/
SELECT first_name || ' ' || last_name AS "Name", COUNT(client_id) AS "Number of visits"
FROM client JOIN animal
    USING (client_id)
HAVING COUNT(client_id) >= 4
GROUP BY first_name || ' ' || last_name;
/*
RESULT:
Jane Lane	4
*/

/*
6. Are there any dogs that need special accommodations?  If so, identify their
owners and add a phone number for quick access.
*/
SELECT name, special_accom, first_name || ' ' || last_name AS "Owner Name",
      phone AS "Owner Number"
FROM animal JOIN client
      USING  (client_id)
WHERE special_accom IS NOT NULL
ORDER BY "Owner Name";
/*
Captain Underpants	does not play well with others	Brittany Taylor	773-555-3214
Buddy	differently abled: 3 legs	Daria Morgendorffer	847-555-1234
Agnes Von Wigglebottom	Diabetes	Jane Lane	847-555-3245
Nacho Dog	Special dog food	Tiffany Blum-Deckler	312-555-3216
Big Foot	old age	Tiffany Blum-Deckler	312-555-3216
*/

/*
7. What is the average amount of money the clients spend?
*/
SELECT first_name || ' ' || last_name AS "Name", COUNT(client_id) 
      AS "Number of Visits", AVG(service_total) AS "Average Total"
FROM client JOIN animal
    USING (client_id)
    JOIN services
    USING (animal_id)
GROUP BY first_name || ' ' || last_name;
/*
Jane Lane	4	360
Tom Sloane	1	360
Daria Morgendorffer	1	65
Tiffany Blum-Deckler	1	65
Chaz Bono	2	360
Patsy Stone	1	225
*/
