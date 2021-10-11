--****PLEASE ENTER YOUR DETAILS BELOW****
--T1b-rm-dm.sql
--Student ID: 30594235
--Student Name: Damien Ambegoda
--Tutorial No: 4

/* Comments for your marker:




*/


/*
1b(i) Create sequences 
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE

CREATE SEQUENCE competitor_seq
INCREMENT BY 1
START WITH 100;

CREATE SEQUENCE entry_seq
INCREMENT BY 1
START WITH 100;

CREATE SEQUENCE team_seq
INCREMENT BY 1
START WITH 100;


/*
1b(ii) Take the necessary steps in the database to record data.
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE

-- entryID, entrystarttime, entryfinishtime, charname, competitor no, carn date, event type code, teamID


INSERT INTO entry VALUES(entry_seq.nextval, null, null, 'Amnesty International', 
(SELECT compno FROM competitor WHERE compphone = '1234567890'), 
(SELECT carndate FROM carnival WHERE carnname = 'RM Summer Series Clayton 2021'),
(SELECT eventtypecode FROM eventtype WHERE eventtypedesc = '21.1 Km Half Marathon'), null);

COMMIT;



/*
1b(iii) Take the necessary steps in the database to record changes. 
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE

UPDATE entry
SET eventtypecode = (SELECT eventtypecode FROM eventtype WHERE eventtypedesc = '10 Km Run')
WHERE compno = 
(SELECT compno FROM competitor WHERE compphone = '1234567890') AND 
carndate = TO_DATE('20-02-2021', 'dd-mm-yyyy');

INSERT INTO TEAM 
VALUES (team_seq.nextval, 'Kenya Speedstars', 
(SELECT carndate FROM carnival WHERE carnname = 'RM Summer Series Clayton 2021'), 1, 'Beyond Blue', 
(SELECT entryid FROM entry where compno = 
(SELECT compno FROM competitor WHERE compphone = '1234567890')AND carndate = (SELECT carndate FROM carnival WHERE carnname = 'RM Summer Series Clayton 2021')));

UPDATE entry 
SET teamid = (SELECT teamid FROM team WHERE teamname = 'Kenya Speedstars') 
WHERE compno = (SELECT compno FROM competitor WHERE compphone = '1234567890') AND 
carndate =(SELECT carndate FROM carnival WHERE carnname = 'RM Summer Series Clayton 2021');

COMMIT;


/*
1b(iv) Take the necessary steps in the database to record changes. 
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE

UPDATE entry 
SET teamid = NULL 
WHERE compno = (SELECT compno FROM competitor WHERE compphone = '1234567890') AND 
carndate = (SELECT carndate FROM carnival WHERE carnname = 'RM Summer Series Clayton 2021');

DELETE FROM team WHERE teamname = 'Kenya Speedstars';

DELETE FROM entry WHERE compno = (SELECT compno FROM competitor WHERE compphone = '1234567890') AND 
carndate = (SELECT carndate FROM carnival WHERE carnname = 'RM Summer Series Clayton 2021');

COMMIT;