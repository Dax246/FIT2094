--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-rm-queries.sql
--Student ID: 30594235
--Student Name: Damien Ambegoda
--Tutorial No: 30594235

/* Comments for your marker:




*/


/*
2(a) Query 1
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE


SELECT TO_CHAR(carndate, 'DY DD MONTH YYYY') AS carnival_date, 
carnname, 
eventtypedesc,
compfname || ' '|| complname as fullname
FROM ((entry e NATURAL JOIN competitor c) NATURAL JOIN carnival v) NATURAL JOIN eventtype
WHERE compemail LIKE '%monash.edu'
ORDER BY carndate ASC, fullname ASC;


/*
2(b) Query 2
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

SELECT TO_CHAR(carndate, 'DY DD MONTH YYYY') AS carnival_date, 
compfname || ' ' || complname as runner,
charname,
charcontact,
eventtypedesc
FROM ((entry e NATURAL JOIN competitor c) NATURAL JOIN charity r) NATURAL JOIN eventtype
WHERE charname IS NOT NULL
ORDER BY carndate ASC, charname ASC, runner ASC;




/*
2(c) Query 3
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE


SELECT c.compno, compfname, complname, compgender, to_char(NVL(twoyrsback,0)) AS twoyrsback, 
to_char(NVL(lastcalyear,0)) AS lastcalyear,
case 
    when (NVL(twoyrsback,0) + NVL(lastcalyear,0)) = 0 then 'Completed No Runs'
    else to_char((NVL(twoyrsback,0) + NVL(lastcalyear,0)))
    end as last2calendaryears
FROM ((
    SELECT compno, count(*) AS lastcalyear
        FROM entry
        WHERE EXTRACT(year from sysdate) - 1 = EXTRACT(year from carndate)
        GROUP BY compno) ly 
    right outer join
    competitor c ON ly.compno = c.compno
    
    left outer JOIN
    
        (SELECT compno, count(*) AS twoyrsback
        FROM entry
        WHERE EXTRACT(year from sysdate) - 2 = EXTRACT(year from carndate)
        GROUP BY compno) lty 
    on c.compno=lty.compno)
    ORDER BY last2calendaryears DESC, compno ASC
;




/*
2(d) Query 4
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE


SELECT DISTINCT carnname,
TO_CHAR(carndate, 'DD MONTH YYYY') AS carnival_date,
floor(months_between(sysdate, oldest) / 12) || ' years ' || 
floor(mod(months_between(sysdate, oldest),12)) || ' month/s old'
AS oldest_competitor_age,

floor(months_between(sysdate, youngest) / 12) || ' years ' || 
floor(mod(months_between(sysdate, youngest),12)) || ' month/s old'
AS youngest_competitor_age

FROM carnival v NATURAL JOIN 
    (SELECT max(compdob) AS youngest, carndate
    FROM carnival v NATURAL JOIN competitor c  NATURAL JOIN entry e
    GROUP BY carndate) NATURAL JOIN
    (SELECT min(compdob) AS oldest, carndate
    FROM carnival v NATURAL JOIN competitor c  NATURAL JOIN entry e
    GROUP BY carndate)
ORDER BY oldest_competitor_age DESC, to_date(carnival_date) ASC;


/*
2(e) Query 5
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

SELECT DISTINCT TO_CHAR(carndate, 'DD-MON-YYYY') AS carnival_date,
carnname,
total_entries5Km
FROM carnival v NATURAL JOIN eventtype t NATURAL JOIN
    (SELECT  carnname, eventtypecode, count(*) AS total_entries5Km
    FROM carnival v NATURAL JOIN entry e NATURAL JOIN eventtype t 
    GROUP BY eventtypecode, carnname) 
WHERE eventtypedesc = '5 Km Run' AND EXTRACT(year from carndate) = '2019'
ORDER BY total_entries5Km DESC, to_date(carnival_date) ASC;

/*
2(f) Query 6
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

SELECT DISTINCT TO_CHAR(carndate, 'DD-MON-YYYY') AS carnival_date,
carnname,
eventtypedesc
FROM 
    (SELECT DISTINCT carndate, carnname, eventtypecode, eventtypedesc
    FROM carnival NATURAL JOIN event NATURAL JOIN eventtype
    
    MINUS 
    
    SELECT DISTINCT  carndate, carnname, eventtypecode, eventtypedesc
    FROM carnival NATURAL JOIN entry NATURAL JOIN eventtype)
ORDER BY to_date(carnival_date), eventtypedesc;

/*
2(g) Query 7
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE


SELECT charname, team_nominations, individual_nominations, team_nominations + individual_nominations AS total_nominations
FROM
    entry NATURAL JOIN
        ((SELECT charname, count(*) AS individual_nominations
        FROM entry
        GROUP BY charname)) NATURAL JOIN
        ((SELECT charname, count(*) AS team_nominations
        FROM team
        GROUP BY charname))
ORDER BY total_nominations DESC, team_nominations DESC, individual_nominations DESC;



/*
2(h) Query 8
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

SELECT t.teamname, to_char(t.carndate, 'DD-MON-YYYY') AS carnivaldate, 
lpad(to_char(c.compno), 4, '0') || ' ' || c.compfname || ' ' || c.complname AS teamleader, 
t.teamnomembers
FROM (TEAM t JOIN entry e ON t.entryid = e.entryid) JOIN competitor c ON e.compno = c.compno
WHERE teamname IN 
    (SELECT teamname
        FROM team
        GROUP BY teamname
        HAVING count(*) = 
            (SELECT max(count(*)) AS total
            FROM team
            GROUP BY teamname))
ORDER BY t.teamname ASC, to_date(carnivaldate) ASC;




/*
2(i) Query 9
*/
--PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE

SELECT compfname || ' ' || complname AS fullname, 
to_char(entrystarttime, 'hh24:mi:ss') AS starttime, 
to_char(entryfinishtime , 'hh24:mi:ss')AS finishtime, 
    (floor((entryfinishtime - entrystarttime) * 24) || ':' ||
    to_char(floor((mod((entryfinishtime - entrystarttime) * 24,1)) * 60)) || ':' ||
     to_char(floor(mod((mod((entryfinishtime - entrystarttime) * 24,1) * 60),1)*60))) AS "RUN DURATION (hh:mi:ss)"

FROM entry NATURAL JOIN competitor NATURAL JOIN eventtype
WHERE carndate = to_date('08-Sep-2019', 'dd-Mon-yyyy') AND eventtypedesc = '5 Km Run'
AND entryfinishtime - entrystarttime < (
    SELECT avg(entryfinishtime - entrystarttime)
    FROM entry NATURAL JOIN competitor NATURAL JOIN eventtype
    WHERE carndate = to_date('04-Apr-2019', 'dd-Mon-yyyy') AND eventtypedesc = '5 Km Run'
    GROUP BY carndate, eventtypecode)
ORDER BY "RUN DURATION (hh:mi:ss)" DESC
;


