-- Generated by Oracle SQL Developer Data Modeler 20.2.0.167.1538
--   at:        2021-02-03 13:01:14 AEDT
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c

set echo on
SPOOL md_schema_output.txt

DROP TABLE appointment CASCADE CONSTRAINTS;

DROP TABLE appointment_nurse CASCADE CONSTRAINTS;

DROP TABLE appointment_service CASCADE CONSTRAINTS;

DROP TABLE insurer CASCADE CONSTRAINTS;

DROP TABLE nurse CASCADE CONSTRAINTS;

DROP TABLE patient CASCADE CONSTRAINTS;

DROP TABLE payment CASCADE CONSTRAINTS;

DROP TABLE provider CASCADE CONSTRAINTS;

DROP TABLE provider_service CASCADE CONSTRAINTS;

DROP TABLE service CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE appointment (
    prov_code      CHAR(6) NOT NULL,
    appt_datetime  DATE NOT NULL,
    appt_room      NUMBER(4) NOT NULL,
    appt_type      VARCHAR2(50) NOT NULL,
    appt_fee       NUMBER(5, 2) NOT NULL,
    patient_no     NUMBER(4) NOT NULL,
    appt_no        NUMBER(7) NOT NULL
);

ALTER TABLE appointment
    ADD CONSTRAINT "Appointment length " CHECK ( appt_type IN ( 'Long', 'Short', 'Standard' ) );

COMMENT ON COLUMN appointment.prov_code IS
    'Provider code';

COMMENT ON COLUMN appointment.appt_datetime IS
    'Appointment date and time';

COMMENT ON COLUMN appointment.appt_room IS
    'Appointment Room';

COMMENT ON COLUMN appointment.appt_type IS
    'Appointment Type which keeps track of appointment length (short, standard or long)';

COMMENT ON COLUMN appointment.appt_fee IS
    'Actual fee for appointment';

COMMENT ON COLUMN appointment.patient_no IS
    'Patient Number';

COMMENT ON COLUMN appointment.appt_no IS
    'Surrogate key for appointment';

ALTER TABLE appointment ADD CONSTRAINT appointment_pk PRIMARY KEY ( patient_no,
                                                                    appt_no );

CREATE TABLE appointment_nurse (
    nurse_no     NUMBER(4) NOT NULL,
    nurse_head   VARCHAR2(3) NOT NULL,
    appt_no      NUMBER(7) NOT NULL,
    patient_no   NUMBER(4) NOT NULL,
    patient_no2  NUMBER(4) NOT NULL
);

ALTER TABLE appointment_nurse
    ADD CONSTRAINT "Is_head_nurse?" CHECK ( nurse_head IN ( 'No', 'Yes' ) );

COMMENT ON COLUMN appointment_nurse.nurse_no IS
    'Nurse Number';

COMMENT ON COLUMN appointment_nurse.nurse_head IS
    'Checks if nurse is head nurse of appointment';

COMMENT ON COLUMN appointment_nurse.appt_no IS
    'Surrogate key for appointment';

COMMENT ON COLUMN appointment_nurse.patient_no2 IS
    'Patient Number';

ALTER TABLE appointment_nurse ADD CONSTRAINT appointment_nurse_pk PRIMARY KEY ( nurse_no,
                                                                                appt_no );

CREATE TABLE appointment_service (
    service_code         NUMBER(4) NOT NULL,
    service_fee_charged  NUMBER(7, 2) NOT NULL,
    appt_no              NUMBER(7) NOT NULL,
    patient_no           NUMBER(4) NOT NULL,
    patient_no2          NUMBER(4) NOT NULL
);

COMMENT ON COLUMN appointment_service.service_code IS
    'Service Code';

COMMENT ON COLUMN appointment_service.service_fee_charged IS
    'Actual fee charged for service';

COMMENT ON COLUMN appointment_service.appt_no IS
    'Surrogate key for appointment';

COMMENT ON COLUMN appointment_service.patient_no2 IS
    'Patient Number';

ALTER TABLE appointment_service ADD CONSTRAINT appointment_service_pk PRIMARY KEY ( service_code );

CREATE TABLE insurer (
    insurer_code      NUMBER(7) NOT NULL,
    insurer_name      VARCHAR2(100) NOT NULL,
    insurer_phone_no  NUMBER(10) NOT NULL
);

COMMENT ON COLUMN insurer.insurer_code IS
    'Insurance Code';

COMMENT ON COLUMN insurer.insurer_name IS
    'Insurer Name';

COMMENT ON COLUMN insurer.insurer_phone_no IS
    'insurer''s phone number';

ALTER TABLE insurer ADD CONSTRAINT insurer_pk PRIMARY KEY ( insurer_code );

CREATE TABLE nurse (
    nurse_no     NUMBER(4) NOT NULL,
    nurse_fname  VARCHAR2(20) NOT NULL,
    nurse_lname  VARCHAR2(50) NOT NULL,
    nurse_phone  NUMBER(10) NOT NULL
);

COMMENT ON COLUMN nurse.nurse_no IS
    'Nurse Number';

COMMENT ON COLUMN nurse.nurse_fname IS
    'Nurse First Name';

COMMENT ON COLUMN nurse.nurse_lname IS
    'Nurse Last Name';

COMMENT ON COLUMN nurse.nurse_phone IS
    'Nurse Phone Number';

ALTER TABLE nurse ADD CONSTRAINT nurse_pk PRIMARY KEY ( nurse_no );

CREATE TABLE patient (
    patient_no                NUMBER(4) NOT NULL,
    patient_fname             VARCHAR2(50) NOT NULL,
    patient_lname             VARCHAR2(50) NOT NULL,
    patient_dob               DATE NOT NULL,
    patient_addr_street_no    NUMBER(4) NOT NULL,
    patient_addr_street_name  VARCHAR2(100) NOT NULL,
    patient_address_suburb    VARCHAR2(50) NOT NULL,
    patient_addr_postcode     NUMBER(4) NOT NULL,
    patient_medicare_no       NUMBER(10) NOT NULL,
    insurer_code              NUMBER(7)
);

COMMENT ON COLUMN patient.patient_no IS
    'Patient Number';

COMMENT ON COLUMN patient.patient_fname IS
    'Patient First Name';

COMMENT ON COLUMN patient.patient_lname IS
    'Patient last name';

COMMENT ON COLUMN patient.patient_dob IS
    'Patient Date of Birth';

COMMENT ON COLUMN patient.patient_addr_street_no IS
    'Patient Address Street Number';

COMMENT ON COLUMN patient.patient_addr_street_name IS
    'Patient Address Street Name';

COMMENT ON COLUMN patient.patient_address_suburb IS
    'Patient Address Suburb Name';

COMMENT ON COLUMN patient.patient_addr_postcode IS
    'Patient Address Postcode';

COMMENT ON COLUMN patient.patient_medicare_no IS
    'Patient''s medicare number';

COMMENT ON COLUMN patient.insurer_code IS
    'Insurance Code';

ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY ( patient_no );

CREATE TABLE payment (
    pay_no       NUMBER(6) NOT NULL,
    pay_from     VARCHAR2(100) NOT NULL,
    pay_amount   NUMBER(7, 2) NOT NULL,
    appt_no      NUMBER(7) NOT NULL,
    patient_no   NUMBER(4) NOT NULL,
    patient_no2  NUMBER(4) NOT NULL
);

ALTER TABLE payment
    ADD CONSTRAINT "Payment From Names" CHECK ( pay_from IN ( 'Insurer', 'Patient' ) );

COMMENT ON COLUMN payment.pay_no IS
    'Payment Number';

COMMENT ON COLUMN payment.pay_from IS
    'Payment From';

COMMENT ON COLUMN payment.pay_amount IS
    'Payment Amount Paid';

COMMENT ON COLUMN payment.appt_no IS
    'Surrogate key for appointment';

COMMENT ON COLUMN payment.patient_no2 IS
    'Patient Number';

ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( pay_no );

CREATE TABLE provider (
    prov_code            CHAR(6) NOT NULL,
    prov_fname           VARCHAR2(50) NOT NULL,
    prov_lname           VARCHAR2(50) NOT NULL,
    prov_reg_no          CHAR(8) NOT NULL,
    prov_first_reg_date  DATE NOT NULL,
    prov_reg_status      VARCHAR2(10) NOT NULL,
    prov_month_charge    NUMBER(10, 2) NOT NULL,
    prov_year_charge     NUMBER(10, 2) NOT NULL,
    prov_title           VARCHAR2(4) NOT NULL,
    prov_type            VARCHAR2(50) NOT NULL,
    prov_normal_room_no  NUMBER(5) NOT NULL
);

ALTER TABLE provider
    ADD CONSTRAINT "Registration Status" CHECK ( prov_reg_status IN ( 'Cancelled', 'Registered', 'Suspended' ) );

COMMENT ON COLUMN provider.prov_code IS
    'Provider code';

COMMENT ON COLUMN provider.prov_fname IS
    'Provider First Name';

COMMENT ON COLUMN provider.prov_lname IS
    'Provider last name';

COMMENT ON COLUMN provider.prov_reg_no IS
    'Provider registration number';

COMMENT ON COLUMN provider.prov_first_reg_date IS
    'Provider first registration date';

COMMENT ON COLUMN provider.prov_reg_status IS
    'Provider Registration Status - Either registered, suspended, cancelled';

COMMENT ON COLUMN provider.prov_month_charge IS
    'Provider Month to Date Total Charge';

COMMENT ON COLUMN provider.prov_year_charge IS
    'Provider Year to Date';

COMMENT ON COLUMN provider.prov_title IS
    'Provider Title';

COMMENT ON COLUMN provider.prov_type IS
    'Provider Type';

COMMENT ON COLUMN provider.prov_normal_room_no IS
    'Provider''s Normal room number';

ALTER TABLE provider ADD CONSTRAINT provider_pk PRIMARY KEY ( prov_code );

CREATE TABLE provider_service (
    prov_code     CHAR(6) NOT NULL,
    service_code  NUMBER(4) NOT NULL
);

COMMENT ON COLUMN provider_service.prov_code IS
    'Provider code';

COMMENT ON COLUMN provider_service.service_code IS
    'Service Code';

ALTER TABLE provider_service ADD CONSTRAINT provider_service_pk PRIMARY KEY ( prov_code,
                                                                              service_code );

CREATE TABLE service (
    service_code      NUMBER(4) NOT NULL,
    service_desc      VARCHAR2(200) NOT NULL,
    service_stnd_fee  NUMBER(7, 2) NOT NULL
);

COMMENT ON COLUMN service.service_code IS
    'Service Code';

COMMENT ON COLUMN service.service_desc IS
    'Service Description';

COMMENT ON COLUMN service.service_stnd_fee IS
    'Service Standard Fee';

ALTER TABLE service ADD CONSTRAINT service_pk PRIMARY KEY ( service_code );

ALTER TABLE appointment_nurse
    ADD CONSTRAINT appointment_nurse FOREIGN KEY ( nurse_no )
        REFERENCES nurse ( nurse_no );

ALTER TABLE appointment_service
    ADD CONSTRAINT appointment_service FOREIGN KEY ( service_code )
        REFERENCES service ( service_code );

ALTER TABLE appointment_nurse
    ADD CONSTRAINT "Appointment's_nurse" FOREIGN KEY ( patient_no,
                                                       appt_no )
        REFERENCES appointment ( patient_no,
                                 appt_no );

ALTER TABLE appointment_service
    ADD CONSTRAINT "appointment's_service" FOREIGN KEY ( patient_no,
                                                         appt_no )
        REFERENCES appointment ( patient_no,
                                 appt_no );

ALTER TABLE patient
    ADD CONSTRAINT "Insurer's_Patients" FOREIGN KEY ( insurer_code )
        REFERENCES insurer ( insurer_code );

ALTER TABLE appointment
    ADD CONSTRAINT "Patient's_appointment" FOREIGN KEY ( patient_no )
        REFERENCES patient ( patient_no );

ALTER TABLE payment
    ADD CONSTRAINT payment_for_appointment FOREIGN KEY ( patient_no,
                                                         appt_no )
        REFERENCES appointment ( patient_no,
                                 appt_no );

ALTER TABLE appointment
    ADD CONSTRAINT "Provider's_appointments" FOREIGN KEY ( prov_code )
        REFERENCES provider ( prov_code );

ALTER TABLE provider_service
    ADD CONSTRAINT "Provider's_Services" FOREIGN KEY ( prov_code )
        REFERENCES provider ( prov_code );

ALTER TABLE provider_service
    ADD CONSTRAINT service_provider FOREIGN KEY ( service_code )
        REFERENCES service ( service_code );

SPOOL off
set echo off

-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            10
-- CREATE INDEX                             0
-- ALTER TABLE                             24
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0