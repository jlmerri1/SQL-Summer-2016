CREATE USER jasonm IDENTIFIED BY jasonm;

CREATE TABLE client
(
  client_id   NUMBER        NOT NULL,
  first_name  VARCHAR2(25)  NOT NULL,
  last_name   VARCHAR2(50)  NOT NULL,
  address     VARCHAR2(50),
  city        VARCHAR2(25),
  state       CHAR(2),
  zip_code    VARCHAR2(10),
  phone       VARCHAR2(20)  NOT NULL,
  email       VARCHAR2(50)            UNIQUE,
  
  CONSTRAINT client_pk 
    PRIMARY KEY (client_id)
);

CREATE TABLE animal
(
  animal_id     NUMBER      NOT NULL,
  client_id     NUMBER      NOT NULL,
  name          VARCHAR(25) NOT NULL,
  arrival_date  DATE        NOT NULL,
  depart_date   DATE,
  special_accom VARCHAR2(100), 
  
  CONSTRAINT animal_pk 
    PRIMARY KEY(animal_id),
  CONSTRAINT animal_fk_client
    FOREIGN KEY(client_id) REFERENCES client (client_id)
);

CREATE TABLE services
(
  service_id    NUMBER      NOT NULL,
  animal_id     NUMBER      NOT NULL,
  service_total NUMBER(9,2) NOT NULL,
  payment_total NUMBER(9,2)           DEFAULT 0,
  refund_total  NUMBER(9,2)           DEFAULT 0,
  
  CONSTRAINT service_pk
    PRIMARY KEY(service_id),
  CONSTRAINT services_fk_animal
    FOREIGN KEY(animal_id) REFERENCES animal(animal_id),
  CONSTRAINT services_ck
    CHECK (service_total >= 0 AND
            payment_total >= 0 AND
            refund_total >= 0)
);

CREATE TABLE employee
(
  emp_id      NUMBER        NOT NULL,
  first_name  VARCHAR2(25)  NOT NULL,
  last_name   VARCHAR2(50)  NOT NULL,
  hire_date   DATE          NOT NULL,
  
  CONSTRAINT employee_pk
    PRIMARY KEY(emp_id)
);

CREATE TABLE service_items
(
  service_id    NUMBER    NOT NULL,
  service_seq   NUMBER    NOT NULL,
  emp_id        NUMBER    NOT NULL,
  service_date  DATE      NOT NULL,
  service_cost  NUMBER(9,2),
  service_desc  VARCHAR2(75),
  
  CONSTRAINT service_items_pk
    PRIMARY KEY(service_id, service_seq),
  CONSTRAINT service_items_fk_employee
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id)
);



CREATE SEQUENCE animal_id_seq
  START WITH 17000;
CREATE SEQUENCE service_seq_seq
  START WITH 1300;
CREATE SEQUENCE service_seq
  START WITH 9950;

CREATE OR REPLACE VIEW past_due_ninety_less AS
  SELECT first_name, last_name, TO_CHAR(service_total-payment_total-refund_total, '$999.99') AS "Balance Due",
          ROUND((SYSDATE - depart_date)) AS "Days Outstanding"
  FROM client join animal USING (client_id)
    JOIN services USING (animal_id)
  WHERE service_total-payment_total-refund_total > 0 
        AND SYSDATE - depart_date > 0 
        AND SYSDATE - depart_date < 90;
  
CREATE OR REPLACE VIEW past_due_ninety_more AS
  SELECT first_name, last_name, TO_CHAR(service_total-payment_total-refund_total, '$999.99') AS "Balance Due",
          ROUND((SYSDATE - depart_date)) AS "Days Outstanding"
  FROM client join animal USING (client_id)
    JOIN services USING (animal_id)
  WHERE service_total-payment_total-refund_total > 0 
        AND SYSDATE - depart_date > 90;
        
CREATE OR REPLACE TRIGGER client_before_update_state
BEFORE INSERT OR UPDATE OF state
ON client
FOR EACH ROW
WHEN (NEW.state != UPPER(NEW.state))
BEGIN
  :NEW.state := UPPER(:NEW.state);
END;
/

CREATE OR REPLACE PROCEDURE update_payment_total
(
  service_id_param        NUMBER,
  payment_total_param     NUMBER
)
AS
BEGIN
  UPDATE services
  SET payment_total = payment_total_param
  WHERE service_id = service_id_param;
END;
/

CREATE OR REPLACE FUNCTION sales_total
(
  first_name_param    VARCHAR2
)
RETURN NUMBER
AS
  emp_id_var NUMBER;
BEGIN
  SELECT emp_id
  INTO emp_id_var
  FROM employee
  WHERE first_name = first_name_param;
  
  RETURN emp_id_var;
END;
/

CREATE OR REPLACE PACKAGE package AS
  PROCEDURE update_payment_total
  (service_id_param NUMBER, payment_total_param NUMBER);
  
  FUNCTION sales_total
  (first_name_param VARCHAR2)
  RETURN NUMBER;
END package;
/
