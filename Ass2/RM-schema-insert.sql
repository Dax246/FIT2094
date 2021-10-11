/*
  FIT2094-FIT3171 2021 SSB Assignment 2
  --RunMonash Schema File and Initial Data--
  
  Description: 
  This file creates the Run Monash tables 
  and populates several of the tables (those shown in purple on the supplied model). 
  You should read this schema file carefully 
  and be sure you understand the various data requirements.

Author: FIT Database Teaching Team
License: Copyright © Monash University, unless otherwise stated. All Rights Reserved.
COPYRIGHT WARNING
Warning
This material is protected by copyright. For use within Monash University only. NOT FOR RESALE.
Do not remove this notice. 
  
*/


DROP TABLE carnival CASCADE CONSTRAINTS;

DROP TABLE charity CASCADE CONSTRAINTS;

DROP TABLE competitor CASCADE CONSTRAINTS;

DROP TABLE emercontact CASCADE CONSTRAINTS;

DROP TABLE entry CASCADE CONSTRAINTS;

DROP TABLE event CASCADE CONSTRAINTS;

DROP TABLE eventtype CASCADE CONSTRAINTS;

DROP TABLE team CASCADE CONSTRAINTS;

CREATE TABLE carnival (
    carndate       DATE NOT NULL,
    carnname       VARCHAR2(50) NOT NULL,
    carndirector   VARCHAR2(50) NOT NULL,
    carnlocation   VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN carnival.carndate IS
    'Date of carnival (unique identifier)';

COMMENT ON COLUMN carnival.carnname IS
    'Carnival name';

COMMENT ON COLUMN carnival.carndirector IS
    'Carnival director''s name';

COMMENT ON COLUMN carnival.carnlocation IS
    'Carnival''s location';

ALTER TABLE carnival ADD CONSTRAINT carnival_pk PRIMARY KEY ( carndate );

ALTER TABLE carnival ADD CONSTRAINT carnival_un UNIQUE ( carnname );

CREATE TABLE charity (
    charname      VARCHAR2(30) NOT NULL,
    charcontact   VARCHAR2(50) NOT NULL,
    charphone     CHAR(10) NOT NULL
);

COMMENT ON COLUMN charity.charname IS
    'Approved charity name';

COMMENT ON COLUMN charity.charcontact IS
    'Charity contact person name';

COMMENT ON COLUMN charity.charphone IS
    'Charity phone number';

ALTER TABLE charity ADD CONSTRAINT charity_pk PRIMARY KEY ( charname );

CREATE TABLE competitor (
    compno           NUMBER(4) NOT NULL,
    compfname        VARCHAR2(30),
    complname        VARCHAR2(30),
    compgender       CHAR(1) NOT NULL,
    compdob          DATE NOT NULL,
    compemail        VARCHAR2(50) NOT NULL,
    compuniopt       CHAR(1) NOT NULL,
    compphone        CHAR(10) NOT NULL,
    compecrelation   CHAR(1) NOT NULL,
    emerconphone     CHAR(10) NOT NULL
);

ALTER TABLE competitor
    ADD CONSTRAINT check_compgender CHECK ( compgender IN (
        'M',
        'F'
    ) );

ALTER TABLE competitor
    ADD CONSTRAINT check_uniopt CHECK ( compuniopt IN (
        'Y',
        'N'
    ) );

ALTER TABLE competitor
    ADD CONSTRAINT check_ecrelation CHECK ( compecrelation IN (
        'P',
        'T',
        'G',
        'F'
    ) );

COMMENT ON COLUMN competitor.compno IS
    'Competitor registration number';

COMMENT ON COLUMN competitor.compfname IS
    'Competitor first name';

COMMENT ON COLUMN competitor.complname IS
    'Competitor last name';

COMMENT ON COLUMN competitor.compgender IS
    'Competitor gender (M or F)';

COMMENT ON COLUMN competitor.compdob IS
    'Competitpr date of birth';

COMMENT ON COLUMN competitor.compemail IS
    'Competitor email address';

COMMENT ON COLUMN competitor.compuniopt IS
    'Competitor university student status (''Y'' or ''N'')';

COMMENT ON COLUMN competitor.compphone IS
    'Competitor phone number';

COMMENT ON COLUMN competitor.compecrelation IS
    'Emergency contact relationship to competitor (P or  T or G or F)
P = Parent
T = Partner
G = Guardian
F = Friend
';

COMMENT ON COLUMN competitor.emerconphone IS
    'Emergency contact phone number';

ALTER TABLE competitor ADD CONSTRAINT competitor_pk PRIMARY KEY ( compno );

CREATE TABLE emercontact (
    emerconphone   CHAR(10) NOT NULL,
    emerconfname   VARCHAR2(30) NOT NULL,
    emerconlname   VARCHAR2(30) NOT NULL
);

COMMENT ON COLUMN emercontact.emerconphone IS
    'Emergency contact phone number';

COMMENT ON COLUMN emercontact.emerconfname IS
    'Emergency Contact First Name';

COMMENT ON COLUMN emercontact.emerconlname IS
    'Emergency Contact Last Name';

ALTER TABLE emercontact ADD CONSTRAINT emercontact_pk PRIMARY KEY ( emerconphone );

CREATE TABLE entry (
    entryid           NUMBER(5) NOT NULL,
    entrystarttime    DATE,
    entryfinishtime   DATE,
    charname          VARCHAR2(30),
    compno            NUMBER(4) NOT NULL,
    carndate          DATE NOT NULL,
    eventtypecode     CHAR(3) NOT NULL,
    teamid            NUMBER(3)
);

COMMENT ON COLUMN entry.entryid IS
    'Surrogate key for EntryNo and CarnDate';

COMMENT ON COLUMN entry.entrystarttime IS
    'The entrant start time';

COMMENT ON COLUMN entry.entryfinishtime IS
    'The entrant finish time';

COMMENT ON COLUMN entry.charname IS
    'Approved charity name';

COMMENT ON COLUMN entry.compno IS
    'Competitor registration number';

COMMENT ON COLUMN entry.carndate IS
    'Date of carnival (unique identifier)';

COMMENT ON COLUMN entry.eventtypecode IS
    'Even type, reflects the distance of the event, e.g 10K is for 10 kilometer ';

ALTER TABLE entry ADD CONSTRAINT entry_pk PRIMARY KEY ( entryid );

CREATE TABLE event (
    carndate        DATE NOT NULL,
    eventtypecode   CHAR(3) NOT NULL
);

COMMENT ON COLUMN event.carndate IS
    'Date of carnival (unique identifier)';

COMMENT ON COLUMN event.eventtypecode IS
    'Even type, reflects the distance of the event, e.g 10K is for 10 kilometer ';

ALTER TABLE event ADD CONSTRAINT event_pk PRIMARY KEY ( carndate,
                                                        eventtypecode );

CREATE TABLE eventtype (
    eventtypecode   CHAR(3) NOT NULL,
    eventtypedesc   VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN eventtype.eventtypecode IS
    'Even type, reflects the distance of the event, e.g 10K is for 10 kilometer ';

COMMENT ON COLUMN eventtype.eventtypedesc IS
    'Even type description';

ALTER TABLE eventtype ADD CONSTRAINT eventtype_pk PRIMARY KEY ( eventtypecode );

CREATE TABLE team (
    teamid          NUMBER(3) NOT NULL,
    teamname        VARCHAR2(30) NOT NULL,
    carndate        DATE NOT NULL,
    teamnomembers   NUMBER(2) NOT NULL,
    charname        VARCHAR2(30),
    entryid         NUMBER(5) NOT NULL
);

COMMENT ON COLUMN team.teamname IS
    'Team name';

COMMENT ON COLUMN team.carndate IS
    'Date of carnival (unique identifier)';

COMMENT ON COLUMN team.teamnomembers IS
    'Number of team members';

COMMENT ON COLUMN team.charname IS
    'Approved charity name';

COMMENT ON COLUMN team.entryid IS
    'Surrogate key for EntryNo and CarnDate';

CREATE UNIQUE INDEX team__idx ON
    team (
        entryid
    ASC );

ALTER TABLE team ADD CONSTRAINT team_pk PRIMARY KEY ( teamid );

ALTER TABLE team ADD CONSTRAINT team_un UNIQUE ( carndate,
                                                 teamname );

ALTER TABLE competitor
    ADD CONSTRAINT competitor_emercontact_fk FOREIGN KEY ( emerconphone )
        REFERENCES emercontact ( emerconphone );

ALTER TABLE entry
    ADD CONSTRAINT entry_charity_fk FOREIGN KEY ( charname )
        REFERENCES charity ( charname );

ALTER TABLE entry
    ADD CONSTRAINT entry_competitor_fk FOREIGN KEY ( compno )
        REFERENCES competitor ( compno );

ALTER TABLE entry
    ADD CONSTRAINT entry_event_fk FOREIGN KEY ( carndate,
                                                eventtypecode )
        REFERENCES event ( carndate,
                           eventtypecode );

ALTER TABLE entry
    ADD CONSTRAINT entry_team_fk FOREIGN KEY ( teamid )
        REFERENCES team ( teamid );

ALTER TABLE event
    ADD CONSTRAINT event_carnival_fk FOREIGN KEY ( carndate )
        REFERENCES carnival ( carndate );

ALTER TABLE event
    ADD CONSTRAINT event_eventtype_fk FOREIGN KEY ( eventtypecode )
        REFERENCES eventtype ( eventtypecode );

ALTER TABLE team
    ADD CONSTRAINT team_carnival_fk FOREIGN KEY ( carndate )
        REFERENCES carnival ( carndate );

ALTER TABLE team
    ADD CONSTRAINT team_charity_fk FOREIGN KEY ( charname )
        REFERENCES charity ( charname );

ALTER TABLE team
    ADD CONSTRAINT team_entry_fk FOREIGN KEY ( entryid )
        REFERENCES entry ( entryid );


-- *****************************************************************
-- NO FURTHER DATA MAY BE ADDED TO THESE TABLES NOR THE SUPPPLIED
-- DATA MODIFIED IN ANY WAY
-- *****************************************************************

-- INSERTING into CARNIVAL
INSERT INTO carnival (
    carndate,
    carnname,
    carndirector,
    carnlocation
) VALUES (
    TO_DATE('01/FEB/2019', 'DD/MON/YYYY'),
    'RM Summer Series Caulfield 2019',
    'Steve Mona',
    '900 Dandenong Rd, Caulfield, VIC, 3145'
);

INSERT INTO carnival (
    carndate,
    carnname,
    carndirector,
    carnlocation
) VALUES (
    TO_DATE('04/APR/2019', 'DD/MON/YYYY'),
    'RM Easter Series Caulfield 2019',
    'Steve Mona',
    '900 Dandenong Rd, Caulfield, VIC, 3145'
);

INSERT INTO carnival (
    carndate,
    carnname,
    carndirector,
    carnlocation
) VALUES (
    TO_DATE('08/SEP/2019', 'DD/MON/YYYY'),
    'RM Spring Series Caulfield 2019',
    'Cathry Freeman',
    '900 Dandenong Rd, Caulfield, VIC, 3145'
);

INSERT INTO carnival (
    carndate,
    carnname,
    carndirector,
    carnlocation
) VALUES (
    TO_DATE('06/FEB/2020', 'DD/MON/YYYY'),
    'RM Autumn Series Caulfield 2020',
    'Mary Imparo',
    '900 Dandenong Rd, Caulfield, VIC, 3145'
);

INSERT INTO carnival (
    carndate,
    carnname,
    carndirector,
    carnlocation
) VALUES (
    TO_DATE('20/FEB/2021', 'DD/MON/YYYY'),
    'RM Summer Series Clayton 2021',
    'Mary Imparo',
    'Scenic Blvd, Clayton, VIC, 3800'
);

-- INSERTING into CHARITY
INSERT INTO charity (
    charname,
    charcontact,
    charphone
) VALUES (
    'RSPCA',
    'Ms. Susan Madden',
    '6140020002'
);

INSERT INTO charity (
    charname,
    charcontact,
    charphone
) VALUES (
    'Beyond Blue',
    'Ms. Julia Gillard',
    '6140040004'
);

INSERT INTO charity (
    charname,
    charcontact,
    charphone
) VALUES (
    'Salvation Army',
    'Mr. Michael Jackson',
    '6140080008'
);

INSERT INTO charity (
    charname,
    charcontact,
    charphone
) VALUES (
    'Amnesty International',
    'Ms. Navinda Pal',
    '6140081234'
);

-- INSERTING into EVENTTYPE
INSERT INTO eventtype (
    eventtypecode,
    eventtypedesc
) VALUES (
    '42K',
    '42.2 Km Marathon'
);

INSERT INTO eventtype (
    eventtypecode,
    eventtypedesc
) VALUES (
    '21K',
    '21.1 Km Half Marathon'
);

INSERT INTO eventtype (
    eventtypecode,
    eventtypedesc
) VALUES (
    '10K',
    '10 Km Run'
);

INSERT INTO eventtype (
    eventtypecode,
    eventtypedesc
) VALUES (
    '5K ',
    '5 Km Run'
);

INSERT INTO eventtype (
    eventtypecode,
    eventtypedesc
) VALUES (
    '3K ',
    '3 Km Community Run/Walk'
);

-- INSERTING into EVENT
INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('01/FEB/2019', 'DD/MON/YYYY'),
    '10K'
);

INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('01/FEB/2019', 'DD/MON/YYYY'),
    '5K '
);

INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('04/APR/2019', 'DD/MON/YYYY'),
    '10K'
);

INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('04/APR/2019', 'DD/MON/YYYY'),
    '21K'
);

INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('04/APR/2019', 'DD/MON/YYYY'),
    '5K '
);

INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('08/SEP/2019', 'DD/MON/YYYY'),
    '3K '
);

INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('08/SEP/2019', 'DD/MON/YYYY'),
    '5K '
);

INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('06/FEB/2020', 'DD/MON/YYYY'),
    '10K'
);

INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('06/FEB/2020', 'DD/MON/YYYY'),
    '21K'
);

INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('06/FEB/2020', 'DD/MON/YYYY'),
    '3K '
);

INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('06/FEB/2020', 'DD/MON/YYYY'),
    '42K'
);

INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('06/FEB/2020', 'DD/MON/YYYY'),
    '5K '
);

INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('20/FEB/2021', 'DD/MON/YYYY'),
    '10K'
);

INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('20/FEB/2021', 'DD/MON/YYYY'),
    '21K'
);

INSERT INTO event (
    carndate,
    eventtypecode
) VALUES (
    TO_DATE('20/FEB/2021', 'DD/MON/YYYY'),
    '5K '
);

-- INSERTING into EMERCONTACT

INSERT INTO emercontact (
    emerconphone,
    emerconfname,
    emerconlname
) VALUES (
    '0433377788',
    'Dave',
    'Freeman'
);

INSERT INTO emercontact (
    emerconphone,
    emerconfname,
    emerconlname
) VALUES (
    '0433555666',
    'Sonya',
    'De Costella'
);

INSERT INTO emercontact (
    emerconphone,
    emerconfname,
    emerconlname
) VALUES (
    '0433666777',
    'Matthew',
    'Smith'
);

INSERT INTO emercontact (
    emerconphone,
    emerconfname,
    emerconlname
) VALUES (
    '0435123567',
    'Elizabeth',
    'Dunn'
);

INSERT INTO emercontact (
    emerconphone,
    emerconfname,
    emerconlname
) VALUES (
    '0411222345',
    'Bob',
    'Ryan'
);

INSERT INTO emercontact (
    emerconphone,
    emerconfname,
    emerconlname
) VALUES (
    '0450789690',
    'Nithin',
    'Pal'
);

INSERT INTO emercontact (
    emerconphone,
    emerconfname,
    emerconlname
) VALUES (
    '0421909808',
    'Ling',
    'Shu'
);

INSERT INTO emercontact (
    emerconphone,
    emerconfname,
    emerconlname
) VALUES (
    '6112345678',
    'Fernando',
    'Rose'
);

INSERT INTO emercontact (
    emerconphone,
    emerconfname,
    emerconlname
) VALUES (
    '6187654321',
    'Adrianna',
    'Rose'
);

INSERT INTO emercontact emercontact (
    emerconphone,
    emerconfname,
    emerconlname
) VALUES (
    '0987654321',
    'Dave',
    'Radcliffe'
);


-- INSERTING into COMPETITOR

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    1,
    'Cathy',
    'Freeman',
    'F',
    TO_DATE('02/JAN/1975', 'DD/MON/YYYY'),
    'cathy@gmail.com',
    'N',
    '0422666777',
    'T',
    '0433377788'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    2,
    'Rob',
    'De Costella',
    'M',
    TO_DATE('15/MAR/1950', 'DD/MON/YYYY'),
    'rob@gmail.com',
    'N',
    '0422888999',
    'T',
    '0433555666'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    3,
    'Brigid',
    'Radcliffe',
    'F',
    TO_DATE('10/OCT/1997', 'DD/MON/YYYY'),
    'brigid@org',
    'N',
    '1234567890',
    'T',
    '0987654321'
);


INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    4,
    'Bob',
    'Ryan',
    'M',
    TO_DATE('02/NOV/1945', 'DD/MON/YYYY'),
    'bob@monash.edu',
    'N',
    '0411222345',
    'T',
    '0435123567'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    5,
    'Sam',
    'Ryan',
    'M',
    TO_DATE('15/APR/2009', 'DD/MON/YYYY'),
    'bob@monash.edu',
    'N',
    '0411222345',
    'G',
    '0411222345'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    6,
    'Jane',
    'Ryan',
    'F',
    TO_DATE('01/JAN/2006', 'DD/MON/YYYY'),
    'bob@monash.edu',
    'N',
    '0411222345',
    'G',
    '0411222345'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    7,
    'Dan',
    'Chu',
    'M',
    TO_DATE('06/JUN/1955', 'DD/MON/YYYY'),
    'dan@monash.edu',
    'N',
    '0403999808',
    'F',
    '0450789690'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    8,
    'Srini',
    'Vash',
    'M',
    TO_DATE('31/AUG/1998', 'DD/MON/YYYY'),
    'srini@monash.edu',
    'Y',
    '0411234567',
    'F',
    '0421909808'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    9,
    'Nithin',
    'Pal',
    'M',
    TO_DATE('30/OCT/1998', 'DD/MON/YYYY'),
    'nithin@monash.edu',
    'Y',
    '0450789690',
    'F',
    '0421909808'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    11,
    'Nan',
    'Shu',
    'F',
    TO_DATE('13/FEB/2010', 'DD/MON/YYYY'),
    'shu@gmail.com',
    'N',
    '0421909808',
    'P',
    '0421909808'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    12,
    'Fan',
    'Shu',
    'M',
    TO_DATE('31/AUG/2005', 'DD/MON/YYYY'),
    'shu@gmail.com',
    'N',
    '0421909808',
    'P',
    '0421909808'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    13,
    'William',
    'Wang',
    'M',
    TO_DATE('23/OCT/2008', 'DD/MON/YYYY'),
    'shu@gmail.com',
    'N',
    '0421909808',
    'G',
    '0421909808'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    14,
    'Pamela',
    'Sim',
    'F',
    TO_DATE('12/DEC/1990', 'DD/MON/YYYY'),
    'sim@gmail.com',
    'Y',
    '0430450678',
    'F',
    '0435123567'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    15,
    'Sebastian',
    'Coe',
    'M',
    TO_DATE('11/NOV/1960', 'DD/MON/YYYY'),
    'coe@gmail.com',
    'N',
    '0421990880',
    'F',
    '0433377788'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    20,
    'Lynn',
    'Nguyen',
    'F',
    TO_DATE('02/OCT/1998', 'DD/MON/YYYY'),
    'lynn@gmail.com',
    'Y',
    '0433123456',
    'F',
    '0433666777'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    10,
    'Ling',
    'Shu',
    'F',
    TO_DATE('23/JUL/1995', 'DD/MON/YYYY'),
    'shu@gmail.com',
    'Y',
    '0421909808',
    'F',
    '0433666777'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    17,
    'Adrianna',
    'Rose',
    'F',
    TO_DATE('11/NOV/1971', 'DD/MON/YYYY'),
    'adrianna@org',
    'N',
    '6187654321',
    'T',
    '6112345678'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    16,
    'Fernando',
    'Rose',
    'M',
    TO_DATE('10/OCT/2007', 'DD/MON/YYYY'),
    'fernando@org',
    'N',
    '6112345678',
    'T',
    '6187654321'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    18,
    'Annamaria',
    'Rose',
    'F',
    TO_DATE('12/DEC/2004', 'DD/MON/YYYY'),
    'fernando@org',
    'N',
    '6112345678',
    'P',
    '6112345678'
);

INSERT INTO competitor (
    compno,
    compfname,
    complname,
    compgender,
    compdob,
    compemail,
    compuniopt,
    compphone,
    compecrelation,
    emerconphone
) VALUES (
    19,
    'Juan',
    'Rose',
    'M',
    TO_DATE('01/JAN/2006', 'DD/MON/YYYY'),
    'fernando@org',
    'N',
    '6112345678',
    'P',
    '6112345678'
);
COMMIT;
