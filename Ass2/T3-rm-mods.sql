--****PLEASE ENTER YOUR DETAILS BELOW****
--T3-rm-mods.sql
--Student ID: 30594235
--Student Name: Damien Ambegoda
--Tutorial No: 4

/* Comments for your marker:

3c: 
rownum = 1 statement added to account for the rare circumstance where two runners
at the same carnival and event both have the fastest speed. Arbitrarily picking
which one is stored in the database


*/


/*
3(a) Changes to live database 1
*/
--PLEASE PLACE REQUIRED SQL STATEMENTS FOR THIS PART HERE

ALTER TABLE entry
    ADD 
         CONSTRAINT unique_carndate_entry UNIQUE (carndate, compno);
COMMIT;


/*
3(b) Changes to live database 2
*/
--PLEASE PLACE REQUIRED SQL STATEMENTS FOR THIS PART HERE

ALTER TABLE entry
    DROP COLUMN run_time;
    
ALTER TABLE entry
ADD run_time numeric(5,2);

UPDATE entry
SET run_time = (entryfinishtime - entrystarttime) * 24* 60
WHERE entrystarttime IS NOT NULL AND entryfinishtime IS NOT NULL;

COMMIT;

/*
3(c) Changes to live database 3
*/

--PLEASE PLACE REQUIRED SQL STATEMENTS FOR THIS PART HERE

ALTER TABLE eventtype
    ADD (fastest numeric(5,2),
    carnname varchar(200),
    fullname varchar(200));

UPDATE eventtype
SET fastest = (
    SELECT min(run_time)
    FROM entry
    WHERE entry.eventtypecode = eventtype.eventtypecode
    );

UPDATE eventtype
SET carnname = (SELECT carnname 
    FROM carnival
    WHERE carndate = (SELECT carndate FROM
    (SELECT DISTINCT carndate 
    FROM entry
    WHERE run_time = eventtype.fastest AND eventtypecode = eventtype.eventtypecode)
    WHERE rownum = 1
    )
    )
    ;

UPDATE eventtype
SET fullname = (SELECT compfname || ' ' || complname
    FROM competitor 
    WHERE compno = (SELECT compno FROM
    (SELECT compno FROM entry
    WHERE run_time = eventtype.fastest AND eventtypecode = eventtype.eventtypecode)
    WHERE rownum = 1)
    );

        
COMMIT;





/*
3(d) Changes to live database 4
*/
--PLEASE PLACE REQUIRED SQL STATEMENTS FOR THIS PART HERE


CREATE TABLE competitor_emergency_contact (
    compno number(4,0),
    emerconphone char(10),
    compecrelation char(1) NOT NULL
    );

ALTER TABLE competitor_emergency_contact
    ADD
        ( CONSTRAINT cec_pk PRIMARY KEY (compno, emerconphone),
          CONSTRAINT competitor_cec_fk FOREIGN KEY (compno) 
                        REFERENCES competitor (compno),
          CONSTRAINT emercontact_cec_fk FOREIGN KEY (emerconphone)
                        REFERENCES emercontact (emerconphone));

ALTER TABLE competitor
    ADD CONSTRAINT check_cecrelation CHECK ( compecrelation IN (
        'P',
        'T',
        'G',
        'F'
    ) );


COMMENT ON COLUMN competitor_emergency_contact.compno IS
    'Competitor number from COMPETITOR';
    
COMMENT ON COLUMN competitor_emergency_contact.emerconphone IS
    'Emergency Contact Phone from EMERCONTACT';

COMMENT ON COLUMN competitor_emergency_contact.compecrelation IS
    'Emergency contact relationship to competitor (P or  T or G or F)
P = Parent
T = Partner
G = Guardian
F = Friend
';
    
INSERT INTO competitor_emergency_contact (compno, emerconphone, compecrelation)
SELECT compno, emerconphone, compecrelation FROM
((SELECT compno FROM competitor) NATURAL JOIN
(SELECT compno, emerconphone FROM competitor) NATURAL JOIN 
(SELECT compno, compecrelation FROM competitor));

ALTER TABLE competitor
DROP COLUMN compecrelation;

ALTER TABLE competitor
DROP COLUMN emerconphone;

COMMIT;


