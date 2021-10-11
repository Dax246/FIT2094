--****PLEASE ENTER YOUR DETAILS BELOW****
--T1a-rm-insert.sql
--Student ID: 30594235
--Student Name: Damien Ambegoda
--Tutorial No: 4

/* Comments for your marker:




*/


/*
1(a) Load selected tables with your own additional test data
*/
--PLEASE PLACE REQUIRED SQL STATEMENT(S) FOR THIS PART HERE


INSERT INTO ENTRY VALUES (1, TO_DATE('10:00:00', 'HH24:MI:SS'), TO_DATE('16:00:00', 'hh24:mi:ss'), 'RSPCA', 1, TO_DATE('01-02-2019', 'dd-mm-yyyy'), '10K', null);
INSERT INTO TEAM VALUES (1, 'Runners', TO_DATE('01-02-2019', 'dd-mm-yyyy'), 1, 'RSPCA', 1);

UPDATE ENTRY
SET teamID = 1
WHERE entryID = 1;

INSERT INTO ENTRY VALUES (2, TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('17:00:00', 'hh24:mi:ss'), 'Beyond Blue', 2, TO_DATE('04-04-2019', 'dd-mm-yyyy'), '21K', null);
INSERT INTO TEAM VALUES (2, 'Speedsters', TO_DATE('04-04-2019', 'dd-mm-yyyy'), 1, 'Beyond Blue', 2);

UPDATE ENTRY
SET teamID = 2
WHERE entryID = 2;

INSERT INTO ENTRY VALUES (3, TO_DATE('17:00:00', 'HH24:MI:SS'), TO_DATE('20:00:00', 'hh24:mi:ss'), null, 3, TO_DATE('08-09-2019', 'dd-mm-yyyy'), '3K', null);
INSERT INTO TEAM VALUES (3, 'Lightning', TO_DATE('08-09-2019', 'dd-mm-yyyy'), 1, 'Salvation Army', 3);

UPDATE ENTRY
SET teamID = 3
WHERE entryID = 3;

INSERT INTO ENTRY VALUES (4, TO_DATE('20:00:00', 'HH24:MI:SS'), TO_DATE('23:00:00', 'hh24:mi:ss'), 'Amnesty International', 4, TO_DATE('06-02-2020', 'dd-mm-yyyy'), '10K', null);
INSERT INTO TEAM VALUES (4, 'Fastest', TO_DATE('06-02-2020', 'dd-mm-yyyy'), 1, 'Amnesty International', 4);

UPDATE ENTRY
SET teamID = 4
WHERE entryID = 4;

INSERT INTO ENTRY VALUES (5, TO_DATE('08:00:00', 'HH24:MI:SS'), TO_DATE('13:00:00', 'hh24:mi:ss'), 'RSPCA', 5, TO_DATE('01-02-2019', 'dd-mm-yyyy'), '5K', null);
INSERT INTO TEAM VALUES (5, 'Quick', TO_DATE('01-02-2019', 'dd-mm-yyyy'), 1, null, 5);

UPDATE ENTRY
SET teamID = 5
WHERE entryID = 5;

INSERT INTO ENTRY VALUES (6, TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('14:00:00', 'hh24:mi:ss'), null, 6, TO_DATE('01-02-2019', 'dd-mm-yyyy'), '5K', null);

UPDATE TEAM
SET teamnomembers = 2
WHERE teamID = 5;

UPDATE ENTRY
SET teamID = 5
WHERE entryID = 6;

INSERT INTO ENTRY VALUES (7, TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('14:00:00', 'hh24:mi:ss'), null, 7, TO_DATE('01-02-2019', 'dd-mm-yyyy'), '5K', null);

UPDATE TEAM
SET teamnomembers = 3
WHERE teamID = 5;

UPDATE ENTRY
SET teamID = 5
WHERE entryID = 7;

INSERT INTO ENTRY VALUES (8, TO_DATE('16:00:00', 'HH24:MI:SS'), TO_DATE('21:00:00', 'hh24:mi:ss'), 'RSPCA', 7, TO_DATE('08-09-2019', 'dd-mm-yyyy'), '3K', null);

INSERT INTO ENTRY VALUES (9, TO_DATE('16:00:00', 'HH24:MI:SS'), TO_DATE('21:00:00', 'hh24:mi:ss'), 'RSPCA', 6, TO_DATE('08-09-2019', 'dd-mm-yyyy'), '3K', null);

UPDATE TEAM
SET teamnomembers = 2
WHERE teamID = 3;

UPDATE ENTRY
SET teamID = 3
WHERE entryID = 9;

INSERT INTO ENTRY VALUES (10, TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('20:00:00', 'hh24:mi:ss'), null, 6, TO_DATE('06-02-2020', 'dd-mm-yyyy'), '42K', null);
INSERT INTO TEAM VALUES (6, 'Road Runners', TO_DATE('06-02-2020', 'dd-mm-yyyy'), 1, 'RSPCA', 10);

UPDATE ENTRY
SET teamID = 6
WHERE entryID = 10;

INSERT INTO ENTRY VALUES (11, TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('20:00:00', 'hh24:mi:ss'), null, 2, TO_DATE('06-02-2020', 'dd-mm-yyyy'), '42K', null);
INSERT INTO ENTRY VALUES (12, TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('20:00:00', 'hh24:mi:ss'), null, 3, TO_DATE('06-02-2020', 'dd-mm-yyyy'), '42K', null);
INSERT INTO ENTRY VALUES (13, TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('20:00:00', 'hh24:mi:ss'), null, 7, TO_DATE('06-02-2020', 'dd-mm-yyyy'), '42K', null);
INSERT INTO ENTRY VALUES (14, TO_DATE('09:30:00', 'HH24:MI:SS'), TO_DATE('19:30:00', 'hh24:mi:ss'), null, 8, TO_DATE('06-02-2020', 'dd-mm-yyyy'), '42K', null);
INSERT INTO ENTRY VALUES (15, TO_DATE('09:23:38', 'HH24:MI:SS'), TO_DATE('15:11:03', 'hh24:mi:ss'), null, 9, TO_DATE('06-02-2020', 'dd-mm-yyyy'), '42K', null);

UPDATE TEAM
SET teamnomembers = 6
WHERE teamID = 6;

UPDATE ENTRY SET teamID = 6 WHERE entryID = 11;
UPDATE ENTRY SET teamID = 6 WHERE entryID = 12;
UPDATE ENTRY SET teamID = 6 WHERE entryID = 13;
UPDATE ENTRY SET teamID = 6 WHERE entryID = 14;
UPDATE ENTRY SET teamID = 6 WHERE entryID = 15;

INSERT INTO ENTRY VALUES (16, TO_DATE('10:32:00', 'HH24:MI:SS'), TO_DATE('16:47:05', 'hh24:mi:ss'), null, 10, TO_DATE('01-02-2019', 'dd-mm-yyyy'), '10K', null);

INSERT INTO ENTRY VALUES (18, TO_DATE('10:00:00', 'HH24:MI:SS'), TO_DATE('14:00:00', 'hh24:mi:ss'), 'Beyond Blue', 10, TO_DATE('04-04-2019', 'dd-mm-yyyy'), '21K', null);

UPDATE TEAM
SET teamnomembers = 2
WHERE teamID = 2;

UPDATE ENTRY
SET teamID = 2
WHERE entryID = 18;

INSERT INTO ENTRY VALUES (19, TO_DATE('17:00:00', 'HH24:MI:SS'), TO_DATE('18:12:00', 'hh24:mi:ss'), null, 12, TO_DATE('08-09-2019', 'dd-mm-yyyy'), '3K', null);

UPDATE TEAM
SET teamnomembers = 3
WHERE teamID = 3;

UPDATE ENTRY
SET teamID = 3
WHERE entryID = 19;

INSERT INTO ENTRY VALUES (20, TO_DATE('19:00:00', 'HH24:MI:SS'), TO_DATE('23:00:00', 'hh24:mi:ss'), 'Amnesty International', 13, TO_DATE('06-02-2020', 'dd-mm-yyyy'), '10K', null);

UPDATE TEAM
SET teamnomembers = 2
WHERE teamID = 4;

UPDATE ENTRY
SET teamID = 4
WHERE entryID = 20;

INSERT INTO ENTRY VALUES (21, TO_DATE('19:00:00', 'HH24:MI:SS'), TO_DATE('23:00:00', 'hh24:mi:ss'), null, 2, TO_DATE('01-02-2019', 'dd-mm-yyyy'), '10K', null);
INSERT INTO TEAM VALUES (7, 'Road Runners', TO_DATE('01-02-2019', 'dd-mm-yyyy'), 1, 'RSPCA', 21);

UPDATE ENTRY
SET teamID = 7
WHERE entryID = 21;

INSERT INTO ENTRY VALUES (22, TO_DATE('19:10:00', 'HH24:MI:SS'), TO_DATE('23:30:00', 'hh24:mi:ss'), null, 2, TO_DATE('08-09-2019', 'dd-mm-yyyy'), '5K', null);
INSERT INTO ENTRY VALUES (23, TO_DATE('18:37:12', 'HH24:MI:SS'), TO_DATE('19:03:03', 'hh24:mi:ss'), null, 5, TO_DATE('08-09-2019', 'dd-mm-yyyy'), '5K', null);
INSERT INTO ENTRY VALUES (24, TO_DATE('17:52:19', 'HH24:MI:SS'), TO_DATE('19:36:48', 'hh24:mi:ss'), null, 9, TO_DATE('08-09-2019', 'dd-mm-yyyy'), '5K', null);

INSERT INTO ENTRY VALUES (25, TO_DATE('19:10:00', 'HH24:MI:SS'), TO_DATE('22:02:00', 'hh24:mi:ss'), null, 4, TO_DATE('04-04-2019', 'dd-mm-yyyy'), '5K', null);

INSERT INTO carnival VALUES (TO_DATE('15-03-2021', 'dd-mm-yyyy'),  'RM Autumn Series Caulfield 2021', 'Steve Mona', '900 Dandenong Rd, Caulfield Vic, 3145');
INSERT INTO event VALUES (TO_DATE('15-03-2021', 'dd-mm-yyyy'), '5K');
INSERT INTO event VALUES (TO_DATE('15-03-2021', 'dd-mm-yyyy'), '42K');

COMMIT;
