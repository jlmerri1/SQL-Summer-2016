INSERT INTO client
  VALUES(1, 'Daria', 'Morgendorffer', '1637 W Farwell Ave #1N', 'Chicago', 'IL', '60626', '847-555-1234', 'dariam@gmail.com');
INSERT INTO client
  VALUES(2, 'Jane', 'Lane', '53 N Chicago Ave', 'Evanston', 'IL', '60201', '847-555-3245', 'mrsjanelane@yahoo.com');
INSERT INTO client
  (client_id, first_name, last_name, phone)
  VALUES(3, 'Brittany', 'Taylor', '773-555-3214');
INSERT INTO client
  VALUES(4, 'Kevin', 'Thompson', '1222 W Belmont Ave #4d', 'Chicago', 'IL', '60657', '312-555-8394', 'kevthom@sbcglobal.net');
INSERT INTO client
  (client_id, first_name, last_name, phone)
  VALUES(5, 'Tiffany', 'Blum-Deckler', '312-555-3216');
INSERT INTO client
  VALUES(6, 'Tom', 'Sloane', '921 Church St', 'Evanston', 'IL', '60201', '224-555-9010', 'ts214@yahoo.com');
INSERT INTO client
  VALUES(7, 'Edina', 'Monsoon', '651 W Diversey PKWY', 'Chicago', 'IL', '60614', '224-555-4221', 'monsoonseason@gmail.com');
INSERT INTO client
  (client_id, first_name, last_name, phone, email)
  VALUES(8, 'Patsy', 'Stone', '312-555-0923', 'abfab@yahoo.com');
  
INSERT INTO animal
  VALUES(14000, 1, 'Buddy', '21-MAY-2016', '22-MAY-2016', 'differently abled: 3 legs');
INSERT INTO animal
  VALUES(14930, 2, 'Agnes Von Wigglebottom', '2-JUN-2016', '6-JUN-2016', 'Diabetes');
INSERT INTO animal
  (animal_id, client_id, name, arrival_date, special_accom)
  VALUES(16002, 5, 'Big Foot', '25-JUL-2016', 'old age');
INSERT INTO animal
  (animal_id, client_id, name, arrival_date)
  VALUES(16003, 5, 'Charlie', '25-JUL-2016');
INSERT INTO animal
  VALUES(13029, 3, 'Captain Underpants', '1-MAY-2016', '7-MAY-2016', 'does not play well with others');
INSERT INTO animal
  (animal_id, client_id, name, arrival_date, depart_date)
  VALUES(11022, 4, 'Woofington', '13-MAR-2016', '13-MAR-2016');
INSERT INTO animal
  VALUES(10023, 5, 'Nacho Dog', '26-MAR-2016', '27-MAR-2016', 'Special dog food');
INSERT INTO animal
  (animal_id, client_id, name, arrival_date, depart_date)
  VALUES(10001, 6, 'Hank the Tank', '23-JAN-2016', '30-JAN-2016');
INSERT INTO animal
  (animal_id, client_id, name, arrival_date, depart_date)
  VALUES(14890, 7, 'Elvis', '24-JUN-2016', '24-JUN-2016');
INSERT INTO animal
  (animal_id, client_id, name, arrival_date)
  VALUES(16111, 2, 'Rico Sauve', '29-JUL-2016');
INSERT INTO animal
  (animal_id, client_id, name, arrival_date)
  VALUES(16112, 2, 'Pinky Brewster', '29-JUL-2016');
INSERT INTO animal
  (animal_id, client_id, name, arrival_date)
  VALUES(16113, 2, 'Bam Bam', '29-JUL-2016');
INSERT INTO animal
  (animal_id, client_id, name, arrival_date, depart_date)
  VALUES(14897, 8, 'Cujo', '30-JUN-2016', '4-JUL-2016');
  
INSERT INTO services
  (service_id, animal_id, service_total, payment_total)
  VALUES(300, 14000, 65, 65);
INSERT INTO services
  (service_id, animal_id, service_total, payment_total)
  VALUES(3414, 14897, 225, 225);
INSERT INTO services
  (service_id, animal_id, service_total)
  VALUES(9943, 16111, 450);
INSERT INTO services
  (service_id, animal_id, service_total)
  VALUES(9944, 16112, 450);
INSERT INTO services
  (service_id, animal_id, service_total)
  VALUES(9945, 16113, 450);
INSERT INTO services
  (service_id, animal_id, service_total, payment_total)
  VALUES(1233, 10023, 65, 65);
INSERT INTO services
  (service_id, animal_id, service_total)
  VALUES(3216, 10001, 360);
INSERT INTO services
  (service_id, animal_id, service_total)
  VALUES(2319, 14930, 225);
  
INSERT INTO employee
  VALUES(332015, 'Jerri', 'Blank', '3-MAR-2015');
INSERT INTO employee
  VALUES(452015, 'Chuck', 'Noblet', '5-APR-2015');
INSERT INTO employee
  VALUES(510201, 'Geoffrey', 'Jellineck', '10-MAY-2016');
INSERT INTO employee
  VALUES(452016, 'Orlando', 'Pinatubo', '5-APR-2015');
INSERT INTO employee
  VALUES(302011, 'Stan', 'Smith', '20-MAR-2015');
INSERT INTO employee
  VALUES(924201, 'Avery', 'Bullock', '24-SEP-2015');
  
  
INSERT INTO service_items
  VALUES(300, 1004, 332015, '21-MAY-2016', 45, 'one night boarding');
INSERT INTO service_items
  VALUES(300, 1005, 302011, '21-MAY-2016', '20', 'bath');
INSERT INTO service_items
  VALUES(3216, 1128, 332015, '23-JAN-2016', 315, 'seven nights boarding');
INSERT INTO service_items
  VALUES(3216, 1129, 302011, '23-JAN-2016', 20, 'bath');
INSERT INTO service_items
  VALUES(3216, 1130, 452016, '23-JAN-2016', 10, 'teeth cleaning');
INSERT INTO service_items
  VALUES(3216, 1131, 924201, '23-JAN-2016', 15, 'nail trimming');
INSERT INTO service_items
  VALUES(2319, 1222, 332015, '2-JUN-2016', 180, 'four nights boarding');
INSERT INTO service_items
  VALUES(2319, 1223, 302011, '2-JUN-2016', 20, 'bath');
INSERT INTO service_items
  VALUES(2319, 1224, 510201, '2-JUN-2016', 10, 'teeth cleaning');
INSERT INTO service_items
  VALUES(2319, 1225, 924201, '2-JUN-2016', 15, 'nail trimming');

COMMIT;

--Entered wrong total for service_id 9943,9944,9945
UPDATE services
SET service_total = 405
WHERE service_id = 9943;

UPDATE services
SET service_total = 405
WHERE service_id = 9944;

UPDATE services
SET service_total = 405
WHERE service_id = 9945;
COMMIT;


INSERT INTO client
  VALUES(9, 'Chaz', 'Bono', '23 W Chicago Ave Apt 48C', 'Chicago', 'IL', '60622', '312-555-9332', 'sonofcher@gmail.com');
INSERT INTO animal
  (animal_id, client_id, name, arrival_date)
  VALUES(animal_id_seq.NEXTVAL, 9, 'Sonny', '31-JUL-2016');
INSERT INTO animal
  (animal_id, client_id, name, arrival_date)
  VALUES(animal_id_seq.NEXTVAL, 9, 'Cher', '31-JUL-2016');
INSERT INTO services
  (service_id, animal_id, service_total)
  VALUES(service_seq.NEXTVAL, 17000, 360);
INSERT INTO services
  (service_id, animal_id, service_total)
  VALUES(service_seq.NEXTVAL, 17001, 360);
INSERT INTO service_items
  VALUES(9950, service_seq_seq.NEXTVAL, 332015, '31-JUl-2016', 315, 'seven nights boarding');
INSERT INTO service_items
  VALUES(9950, service_seq_seq.NEXTVAL, 302011, '31-JUl-2016', 20, 'bath');
INSERT INTO service_items
  VALUES(9950, service_seq_seq.NEXTVAL, 510201, '31-JUl-2016', 10, 'teeth cleaning');
INSERT INTO service_items
  VALUES(9950, service_seq_seq.NEXTVAL, 924201, '31-JUl-2016', 15, 'nail trimming');
INSERT INTO service_items
  VALUES(9951, service_seq_seq.NEXTVAL, 332015, '31-JUl-2016', 315, 'seven nights boarding');
INSERT INTO service_items
  VALUES(9951, service_seq_seq.NEXTVAL, 302011, '31-JUl-2016', 20, 'bath');
INSERT INTO service_items
  VALUES(9951, service_seq_seq.NEXTVAL, 510201, '31-JUl-2016', 10, 'teeth cleaning');
INSERT INTO service_items
  VALUES(9951, service_seq_seq.NEXTVAL, 924201, '31-JUl-2016', 15, 'nail trimming');  
  
COMMIT;

INSERT INTO service_items
  VALUES(3414, service_seq_seq.NEXTVAL, 332015, '30-JUN-2016', 180, 'four nights boarding');
INSERT INTO service_items
  VALUES(3414, service_seq_seq.NEXTVAL, 302011, '30-JUN-2016', 20, 'bath');
INSERT INTO service_items
  VALUES(3414, service_seq_seq.NEXTVAL, 510201, '30-JUN-2016', 10, 'teeth cleaning');
INSERT INTO service_items
  VALUES(3414, service_seq_seq.NEXTVAL, 924201, '2-JUN-2016', 15, 'nail trimming');
INSERT INTO service_items
  VALUES(9943, service_seq_seq.NEXTVAL, 332015, '29-JUN-2016', 405, 'nine nights boarding');
INSERT INTO service_items
  VALUES(9944, service_seq_seq.NEXTVAL, 332015, '29-JUN-2016', 405, 'nine nights boarding');
INSERT INTO service_items
  VALUES(9945, service_seq_seq.NEXTVAL, 332015, '29-JUN-2016', 405, 'nine nights boarding');
INSERT INTO service_items
  VALUES(1233, service_seq_seq.NEXTVAL, 332015, '26-MAR-2016', 45, 'one night boarding');
INSERT INTO service_items
  VALUES(1233, service_seq_seq.NEXTVAL, 302011, '26-MAR-2016', 20, 'bath');
COMMIT;