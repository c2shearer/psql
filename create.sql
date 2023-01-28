-- Creation of entire Database

CREATE DATABASE solent;

CREATE TABLE county(
    county_id SERIAL PRIMARY KEY,
    county_name VARCHAR(30) NOT NULL
);

CREATE TABLE area(
    area_id SERIAL PRIMARY KEY,
    county_id INT NOT NULL,
    area_name VARCHAR(60) NOT NULL,
    FOREIGN KEY (county_id) REFERENCES county(county_id)
);

CREATE TABLE address(
    address_id SERIAL PRIMARY KEY,
    area_id INT NOT NULL,
    address_post_code VARCHAR(8) NOT NULL,
    address_name VARCHAR(50) NOT NULL,
    FOREIGN KEY (area_id) REFERENCES area(area_id)
);

CREATE TABLE customer(
    customer_id SERIAL PRIMARY KEY,
    address_id INT NOT NULL,
    customer_fname VARCHAR(50) NOT NULL,
    customer_lname VARCHAR(50) NOT NULL,
    customer_tel VARCHAR(20) NOT NULL,
    customer_email VARCHAR(50) NOT NULL,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE role(
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(21) NOT NULL
);

CREATE TABLE staff(
    staff_id SERIAL PRIMARY KEY,
    address_id INT NOT NULL,
    staff_fname VARCHAR(50) NOT NULL,
    staff_lname VARCHAR(50) NOT NULL,
    staff_tel VARCHAR(20) NOT NULL,
    staff_email VARCHAR(50) NOT NULL,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE staff_role(
    role_id INT NOT NULL,
    staff_id INT NOT NULL,
    PRIMARY KEY(staff_id, role_id),
    FOREIGN KEY(staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY(role_id) REFERENCES role(role_id)
);

CREATE TABLE staff_branch(
    branch_id INT NOT NULL,
    staff_id INT NOT NULL,
    PRIMARY KEY(branch_id, staff_id),
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id),
    FOREIGN KEY(staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE branch(
    branch_id SERIAL PRIMARY KEY,
    address_id INT NOT NULL,
    branch_name VARCHAR(50) NOT NULL,
    FOREIGN KEY(address_id) REFERENCES address(address_id)
);

CREATE TABLE staff_service(
    staff_id INT NOT NULL,
    service_id INT NOT NULL,
    PRIMARY KEY(staff_id, service_id),
    FOREIGN KEY(staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY(service_id) REFERENCES service(service_id)
);

CREATE TABLE service(
    service_id SERIAL PRIMARY KEY,
    boat_id INT NOT NULL,
    service_type VARCHAR(50) NOT NULL,
    service_last_update DATE NOT NULL,
    status status NOT NULL,
    FOREIGN KEY(boat_id) REFERENCES boat(boat_id)
);

CREATE TABLE boat(
    boat_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    boat_dimension VARCHAR(30) NOT NULL,
    boat_mic VARCHAR(50) NOT NULL,
    boat_name VARCHAR(50) NOT NULL,
    boat_engine VARCHAR(10) NOT NULL,
    boat_fuel VARCHAR(16) NOT NULL,
    boat_capacity INT(2) NOT NULL,
    boat_built DATE NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE service_fault(
    service_id INT NOT NULL,
    fault_id INT NOT NULL,
    PRIMARY KEY(service_id, fault_id),
    FOREIGN KEY(service_id) REFERENCES service(service_id),
    FOREIGN KEY(fault_id) REFERENCES fault(fault_id)
);

CREATE TABLE fault(
    fault_id SERIAL PRIMARY KEY,
    fault_name VARCHAR(50) NOT NULL,
    fault_category VARCHAR(50) NOT NULL
);

CREATE TYPE status AS ENUM(
    'PREBOOK',
    'ONGOING',
    'COMPLETED'
);