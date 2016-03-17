<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [MySQL](#mysql)
  - [ER Diagram](#er-diagram)
  - [Best practice my.cnf](#best-practice-mycnf)
  - [Add plugin?](#add-plugin)
  - [Slave/Master](#slavemaster)
  - [Trobule](#trobule)
  - [TSV/CSV](#tsvcsv)
  - [Import](#import)
  - [Copy DataBase/Table](#copy-databasetable)
  - [Export File](#export-file)
  - [Character code](#character-code)
  - [PARTITIONS](#partitions)
  - [Row](#row)
  - [INSERT](#insert)
  - [UPDATE](#update)
  - [DELETE/TRUNCATE](#deletetruncate)
  - [SELECT](#select)
  - [SHOW](#show)
  - [CREATE](#create)
  - [DROP](#drop)
  - [ALTER](#alter)
  - [JOIN](#join)
  - [CASE](#case)
  - [IN](#in)
  - [DATE](#date)
  - [FUNCTION](#function)
  - [Other](#other)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

MySQL
===

## ER Diagram

ALL DB
* [Windows only](http://www.wind.sannet.ne.jp/m_matsu/developer/a5m2/)

MySQL
* [MySQL Workbench](http://dev.mysql.com/downloads/workbench/)

## Best practice my.cnf

* [kamipo-san's my.cnf](https://github.com/kamipo/etcfiles/blob/master/etc/my.cnf)
 * [default_character_set, character_set_server](http://kamipo.github.io/talks/20150827-myna201508/#/step-12)

   > utf8mb4_bin or utf8mb4_general_ci

* [yoku0825-san](https://github.com/yoku0825)
 * [dotfiles my.cnf](https://github.com/yoku0825/dotfiles/blob/master/my.cnf)
 * [my_setup my.cnf](https://github.com/yoku0825/my_setup/blob/master/my.cnf)

## Add plugin?

* [semisync](https://dev.mysql.com/doc/refman/5.6/ja/replication-semisync-installation.html)
* [HandlerSocket](https://github.com/DeNA/HandlerSocket-Plugin-for-MySQL)
* [Mroonga](http://mroonga.org/ja/)
* [Q4M](http://q4m.github.io/)
* [InnoDB Memcached](http://dev.mysql.com/doc/refman/5.6/ja/innodb-memcached-setup.html)

## Slave/Master

Slave or Master  
Slave is shown at infomation. Master is empty.
```sql
SHOW MASTER STATUS\G
SHOW SLAVE  STATUS\G
```

[Slave safely stop](http://qiita.com/catatsuy/items/8f2fbea88b9bc7b8acf7)
```sql
SET GLOBAL innodb_fast_shutdown=0;
STOP SLAVE IO_THREAD;

SHOW SLAVE STATUS\G

    Read_Master_Log_PosとExec_Master_Log_Posが一致する事を確認

STOP SLAVE ALL;
```

## Trobule

[Check status](http://qiita.com/muran001/items/14f19959d4723ffc29cc)
```sql
SHOW GLOBAL STATUS;
SHOW PROCESSLIST;
SHOW FULL PROCESSLIST;

KILL xxxx;
```

## TSV/CSV

'\47' is SingleQuote.  
$0 is all words. $1-N is separate words.  
Check kazuakim_null isn't exist.

TSV
```bash
$ mysql --skip-column-names -u<Account> -h<Host> -p <DataBase> -e "
SELECT IFNULL(<Tab1>.<Column1>, 'kazuakim_null') AS Column1, IFNULL(<Tab1>.<Column2>, 'kazuakim_null') AS Column2
FROM <Table1> AS <Tab1>
" > /tmp/<dumpFile>.tsv

$ awk -F '\t' '{print "INSERT INTO <Table1> (<Column1>, <Column2>, ...) VALUES ("$1",\047"$2"\047,...);"}' /tmp/<dumpFile>.tsv > /tmp/<dumpFile>.sql
$ sed -i -e s/\'kazuakim_null\'/NULL/ /tmp/<dumpFile>.sql
```

CSV
```bash
$ mysql --skip-column-names -u<Account> -h<Host> -p <DataBase> -e "
SELECT IFNULL(<Tab1>.<Column1>, 'kazuakim_null') AS Column1, IFNULL(<Tab1>.<Column2>, 'kazuakim_null') AS Column2
FROM <Table1> AS <Tab1>
" | sed -e 's/\t/,/g' > /tmp/<dumpFile>.csv

$ awk -F ',' '{print "INSERT INTO <Table1> (<Column1>, <Column2>, ...) VALUES ("$1",\047"$2"\047,...);"}' /tmp/<dumpFile>.csv > /tmp/<dumpFile>.sql
$ sed -i -e s/\'kazuakim_null\'/NULL/ /tmp/<dumpFile>.sql
```

CSV (Exist heder case)
```bash
$ mysql -u<Account> -h<Host> -p <DataBase> -e "
SELECT IFNULL(<Tab1>.<Column1>, 'kazuakim_null') AS Column1, IFNULL(<Tab1>.<Column2>, 'kazuakim_null') AS Column2
FROM <Table1> AS <Tab1>
INTO OUTFILE '/tmp/<dumpFile>.csv' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '' LINES TERMINATED BY '\n';
"

$ sed -i -e '1d' /tmp/<dumpFile>.csv
$ awk -F ',' '{print "INSERT INTO <Table1> (<Column1>, <Column2>, ...) VALUES ("$1",\047"$2"\047,...);"}' /tmp/<dumpFile>.csv > /tmp/<dumpFile>.sql
$ sed -i -e s/\'kazuakim_null\'/NULL/ /tmp/<dumpFile>.sql
```

Big TSV
```bash
$ mysql --skip-column-names -u<Account> -h<Host> -p <DataBase> -e "
SELECT IFNULL(<Tab1>.<Column1>, 'kazuakim_null') AS Column1, IFNULL(<Tab1>.<Column2>, 'kazuakim_null') AS Column2
FROM <Table1> AS <Tab1>
" > /tmp/<dumpFile>.tsv

$ awk -F $"\t" '{print "(\47"$1"\47, "$2", \47"$3"\47),"}' /tmp/<dumpFile>.tsv > /tmp/<dumpfile>_param.txt
$ sed -i -e s/\'kazuakim_null\'/NULL/ /tmp/<dumpfile>_param.txt
$ split -l 10000 /tmp/<dumpfile>_param.txt /tmp/<dumpfile>_param_split.
$ sed -i -e '1i INSERT INTO <Table1> VALUES' /tmp/<dumpfile>_param_split.*
$ sed -i -e '$s/),/);/' /tmp/<dumpfile>_param_split.*
$ for f in <dumpfile>_param_split.* ; do
    mysql -u<Account> -h<Host> -p<Password> <DataBase>  < $f
done
```

## Import

CUI
```bash
$ ls
  <dumpFile>
$ mysql -u<Account> -h<Host> -p <DataBase>  < ./<dumpFile>
```

Command
```sql
$ ls
  <dumpFile>
$ mysql -u<Account> -h<Host> -p <DataBase>

<Confirm SQL>

BEGIN;
SOURCE ./<dumpFile>
<Confirm SQL>


COMMIT;
```

## Copy DataBase/Table

Copy DataBase
```bash
$ mysqldump -u<Account> -h<Host> -p <DataBase1>    > /tmp/<dumpFile>.dump
$ mysql     -u<Account> -h<Host> -p <New DataBase> < /tmp/<dumpFile>.dump
```

Copy Table
```sql
CREATE TABLE <New DataBase>.<New Table1> LIKE          <DataBase1>.<Table1>;
INSERT INTO  <New DataBase>.<New Table1> SELECT * FROM <DataBase1>.<Table1>;
```

## Export File

--skip-add-drop-table:Do not write DROP TABLE statements.  
--no-create-info:     Do not write CREATE TABLE statements.

Tables dump
```bash
$ mysqldump -u<Account> -h<Host> -p <DataBase> \
 --default-character-set=utf8 --single-transaction --skip-lock-tables -c -e -q --result-file='/tmp/<dumpFile>.dump' --tables \
 <Table1> <Table2>;
$ vi /tmp/<dumpFile>.dump
  Check execute results.

$ cd /tmp
$ tar zcvf <dumpFile>.dump.tar.gz <dumpFile>.dump
```

Where dump(sub query join sample) / table
```bash
$ mysqldump -u<Account> -h<Host> -p <DataBase> \
 --where='id IN (SELECT <tab1>.id FROM <Table1> AS <tab1> INNER JOIN <Table2> AS <tab2> ON <tab1>.id = <tab2>.t1_id WHERE <tab2>.status = 1)' \
 --default-character-set=utf8 --single-transaction --skip-lock-tables -c -e -q --result-file='/tmp/<Table1>.dump' --tables \
 <Table1>;
$ vi /tmp/<Table1>.dump
  Check execute results.
```

## Character code

["SET CHARACTER SET" is similar to "SET NAMES" but sets character_set_connection and collation_connection to character_set_database and collation_database.](http://dev.mysql.com/doc/refman/5.6/ja/charset-connection.html)  
EUC-JP
```sql
SET NAMES ujis; SET CHARACTER SET ujis;
```
UTF-8
```sql
SET NAMES utf8; SET CHARACTER SET utf8;
```

## PARTITIONS

Check partitions
```sql
SELECT isp.TABLE_SCHEMA, isp.TABLE_NAME, isp.PARTITION_NAME, isp.PARTITION_ORDINAL_POSITION, isp.TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS AS isp WHERE isp.TABLE_SCHEMA = DATABASE() AND isp.PARTITION_NAME IS NOT NULL ORDER BY isp.TABLE_NAME ASC, isp.PARTITION_NAME ASC;
```

Update normal table to partitions table
```sql
SHOW CREATE TABLE <Table1>;

ALTER TABLE <Table1> PARTITION BY RANGE COLUMNS(created_at) (
    PARTITION p201401 VALUES LESS THAN ('2014-02-01') ENGINE = InnoDB,
    PARTITION p201402 VALUES LESS THAN ('2014-03-01') ENGINE = InnoDB);

SHOW CREATE TABLE <Table1>;
```

Add new partitions table
```sql
SHOW CREATE TABLE <Table1>;

ALTER TABLE <Table1> ADD PARTITION (
    PARTITION p201401 VALUES LESS THAN ('2014-02-01'),
    PARTITION p201402 VALUES LESS THAN ('2014-03-01'));

SHOW CREATE TABLE <Table1>;
```

Delete partitions
```sql
SHOW CREATE TABLE <Table1>;

ALTER TABLE <Table1> DROP PARTITION p201401, p201402;

SHOW CREATE TABLE <Table1>;
```

## Row

row number
```sql
SET @row_number:=0;
SELECT @row_number:=@row_number+1 AS row_number
FROM <Table1> AS <Tab1>;
```

[Group columns row number](http://ja.stackoverflow.com/questions/11654/mysql%E3%81%AEsql%E3%81%AB%E3%81%A6%E3%82%B0%E3%83%AB%E3%83%BC%E3%83%97%E5%86%85%E3%81%A7%E9%80%A3%E7%95%AA%E3%82%92%E4%BB%98%E3%81%91%E3%81%9F%E3%81%84)
```sql
SET @row_number:=0, @variable1:=NULL [, @variable2:=NULL];
SELECT IF(@variable1 <> <Tab1>.<Column1> [ AND @variable2 <> <Tab1>.<Column2> ], @row_number:=1, @row_number:=@row_number+1) AS row_number
    , @variable1:=<Tab1>.<Column1> AS <Col1>
   [, @variable2:=<Tab1>.<Column2> AS <Col2> ]
FROM <Table1> AS <Tab1>
ORDER BY <Tab1>.<Column1> ASC [, <Tab1>.<Column2> ASC ];
```

## INSERT

(Bulk )All columns set
```sql
INSERT INTO <Table1> VALUES
    (<ColumnData1>, <ColumnData2>, ...),
    (<ColumnData1>, <ColumnData2>, ...);
```

(Bulk )Insert
```sql
INSERT INTO <Table1> (<Column1>, <Column2>, ...) VALUES
    (<ColumnData1>, <ColumnData2>, ...),
    (<ColumnData1>, <ColumnData2>, ...);
```

Insert duplicate key update
```sql
INSERT INTO <Table1> (<Column1>, <Column2>, ...) VALUES
    (<ColumnData1>, <ColumnData2>, ...)
ON DUPLICATE KEY UPDATE <Column2> = <ColumnData2>, <Column3> = <ColumnData3>;
```

Insert select
```sql
INSERT INTO <Table1> (<Column1>, <Column2>, ...)
    SELECT <ColumnData1>, <ColumnData2>, ...;
```

[Insert select duplicate key update](http://qiita.com/yuzroz/items/f0eccf847b2ea42f885f)
```sql
INSERT INTO <Table1> (<Column1>, <Column2>, ...)
    SELECT <tab2>.<ColumnData1>, <tab2>.<ColumnData2>, ...
    FROM <Table2> AS <tab2>
    ORDER BY <tab2>.<ColumnData1>
ON DUPLICATE KEY UPDATE
    <Column2> = IF(<Table1>.<Column1> < <tab2>.<ColumnData1>, <Table1>.<Column1>, <tab2>.<ColumnData1>),
    <Column3> = CONCAT(<Table1>.<Column3>, '_', IFNULL(<Table1>.<Column1>, ''));
```

[Insert select group by duplicate key update](http://stackoverflow.com/questions/16935896/mysql-on-duplicate-key-update-while-inserting-a-result-set-from-a-query)
```sql
INSERT INTO <Table1> (<Column1>, <Column2>, ...)
    SELECT <tab2>.<ColumnData1>, @group_column := COUNT(<tab2>.<ColumnData2>), ...
    FROM <Table2> AS <tab2>
    GROUP BY <tab2>.<ColumnData1>
ON DUPLICATE KEY UPDATE
    <Column2> = <Table1>.<Column2> + @group_column;
```

## UPDATE

Normal
```sql
UPDATE <Table1> SET <Column1> = <ColumnData1> WHERE <UniqueColumn1> = <UniqueColumnData1>;
UPDATE <Table1> SET <Column1> = <ColumnData2> WHERE <UniqueColumn1> = <UniqueColumnData2>;
```

Table JOIN
```sql
UPDATE <Table1> AS <tab1>
    INNER JOIN <Table2> AS <tab2>
    ON <tab1>.id = <tab2>.tab1_id
    SET <tab1>.<Column1> = <ColumnData1> WHERE <UniqueColumn1> = <UniqueColumnData1>;
```

[Good1](http://d.hatena.ne.jp/knowledgetree/20100325/1269530022)
```sql
UPDATE <Table1> SET
    <Column1> = CASE <UniqueColumn1>
        WHEN <UniqueColumnData1> THEN <ColumnData1>
        WHEN <UniqueColumnData2> THEN <ColumnData2>
        END
WHERE <UniqueColumn1> IN (...);
```

[Good2](http://qiita.com/masuidrive/items/0671ea7efa91a99c0268)
```sql
CREATE TEMPORARY TABLE tmp_<Table1>(<UniqueColumn1>, <Column1>, ...);

INSERT INTO tmp_<Table1>(<UniqueColumn1>, <Column1>) VALUES
    (<UniqueColumnData1>, <ColumnData1>),
    (<UniqueColumnData2>, <ColumnData2>);

UPDATE <Table1> AS <tab1>
    INNER JOIN tmp_<Table1> AS <tmp>
    ON <tab1>.<UniqueColumn1> = <tmp>.<UniqueColumn1>
    SET <tab1>.<Column1> = <tmp>.<UniqueColumn1>;
```

Multi Table
```sql
UPDATE <Table1> AS <tab1>
    INNER JOIN <Table2> AS <tab2>
    ON <tab1>.id = <tab2>.tab1_id
    SET <tab1>.<Column1> = <ColumnData1>, <tab2>.<Column2> = <ColumnData2>
    WHERE <UniqueColumn1> = <UniqueColumnData1>;
```

## DELETE/TRUNCATE

Delete
```sql
DELETE FROM <Table1> WHERE <Column1> = <ColumnData1>;
```
Delete - JOIN
```sql
DELETE <Table1> FROM <Table1>
    INNER JOIN <Table2> AS <tab2>
    ON <Table1>.<Column1> = <tab2>.<Column2>;
```

Truncate
```sql
TRUNCATE TABLE <Table1>;
```

## SELECT

Search using Column
```sql
SELECT isc.TABLE_NAME, isc.COLUMN_NAME, isc.COLUMN_TYPE, isc.IS_NULLABLE, isc.COLUMN_KEY, isc.EXTRA FROM INFORMATION_SCHEMA.COLUMNS AS isc WHERE isc.TABLE_SCHEMA = DATABASE()
AND isc.COLUMN_NAME = <Column1>;
```

Show using DataBase
```sql
SELECT DATABASE();
```

Show empty min id
```sql
SELECT MIN(<tab1>.<Column1> + 1) AS min_<Column1>
FROM <Table1> AS <tab1>
WHERE NOT EXISTS (
    SELECT <sub_tab1>.<Column1>
    FROM <Table1> AS <sub_tab1>
    WHERE (<tab1>.<Column1> + 1) = <sub_tab1>.<Column1>);
```

Range column
```sql
SELECT <tab1>.<Column1>
FROM <Table1> AS <tab1>
WHERE NOW() BETWEEN start_date AND end_date;
```

DISTINCT to EXISTS
```sql
before)
SELECT DISTINCT <tab1>.<Column1>
FROM <Table1> AS <tab1>
INNER JOIN <Table2> AS <tab2>
ON <tab1>.<Column1> = <tab2>.<Column3>

after)
SELECT <tab1>.<Column1>
FROM <Table1> AS <tab1>
WHERE EXISTS (
    SELECT <tab2>.<Column3>
    FROM <Table2> AS <tab2>
    WHERE <tab1>.<Column1> = <tab2>.<Column3>);
```

## SHOW

Index
```sql
SHOW INDEX FROM <Table1>;
```

DataBases
```sql
SHOW DATABASES;
```

Create tabe
```sql
SHOW CREATE TABLE <Table1>\G
```

Max string
```sql
SHOW variables LIKE 'max_allowed_packet';
```

## CREATE

DataBase
```sql
CREATE DATABASE <DataBase1>;
```

Table  
> Don't use direct CREATE TABLE commands and should use ER Diagram(check top page).

TEMPORARY TABLE - SELECT
```sql
CREATE TEMPORARY TABLE tmp_<Table1> (
    <Column1 schema>,
    <Column2 schema>,
    ...,
    PRIMARY KEY (<Column1>,...))
    SELECT <ColumnData1>, <ColumnData2>, ...;
```

INDEX
```sql
CREATE INDEX <Index1> ON <Table1>(<Column1>);
```

## DROP

Table
```sql
DROP TABLE <Table1>, <Table2>;
```

IF Table exists
```sql
DROP TABLE IF EXISTS <Table1> CASCADE;
```

DataBase
```sql
DROP DATABASE <DataBase1>, <DataBase2>;
```

## ALTER

Add column
```sql
ALTER TABLE <Table1> ADD <Column schema> AFTER <Previous column>;
```

Modify column
```sql
ALTER TABLE <Table1> CHANGE <Previous column name> <Column schema>;
```

Modify column schema
```sql
ALTER TABLE <Table1> MODIFY <Column schema>;
```

Delete Column
```sql
ALTER TABLE <Table1> DROP <Column1>;
```

Delete Index
```sql
ALTER TABLE <Table1> DROP INDEX <Index1>;
```

Update auto_increment
```sql
ex) now :389, next_increment:391 => next_increment:390.

SELECT MAX(<tab1>.id) AS max_num FROM <Table1> AS <tab1>\G

   MAX(id): 389

SHOW TABLE STATUS LIKE <Table1>\G

   Auto_increment: 391

ALTER TABLE <Table1> AUTO_INCREMENT = 390;
```

Modify table name
```sql
ALTER TABLE <Table1> RENAME <Table2>;
```

## JOIN

[JOIN Exsample](http://www.codeproject.com/Articles/33052/Visual-Representation-of-SQL-Joins)

![JOIN Image](http://www.codeproject.com/KB/database/Visual_SQL_Joins/Visual_SQL_JOINS_V2.png)

## CASE

Simple CASE
```sql
SELECT CASE <Column1>
    WHEN <ColumnData1-1> THEN <Data1-1>
    WHEN <ColumnData1-2> THEN <Data1-2>
    ELSE <Data1-3>
    END AS <Column1_RENAME>
```

Search CASE
```sql
SELECT CASE
    WEHN <Column1> = <ColumnData1-1> THEN <Data1-1>
    WHEN <Column1> = <ColumnData1-2> THEN <Data1-2>
    ELSE <Data1-3>
    END AS <Column1_RENAME>
```

GROUP BY - CASE
```sql
SELECT
    CASE
        WEHN <tab1>.<Column1> = <ColumnData1-1> THEN <Data1-1>
        WHEN <tab1>.<Column1> = <ColumnData1-2> THEN <Data1-2>
        ELSE <tab1>.<Data1-3>
        END AS <Column1_RENAME>
    FROM <Table1> AS <tab1>
    GROUP BY <Column1_RENAME>
```

## IN

multi IN
```sql
SELECT <tab1>.<Column1>
FROM <Table1> AS <tab1>
WHERE (<tab1>.<column1>, <tab1>.<column2> [, <tab1>.<column3>]) IN (
    (<ColumnData1-1>, <ColumnData2-1> [, <ColumnData3-1>]) [,
    (<ColumnData1-2>, <ColumnData2-2> [, <ColumnData3-2>]) ] );
```

## DATE

UTC+9(Japanese timezone)
```sql
SELECT DATE_ADD(NOW(), INTERVAL 9 hour);
```

Char date
```sql
SELECT CAST(CONCAT(<Column1>, '000000') AS DATE) FROM <Table1>;
```

DATE_FORMAT
```sql
SELECT DATE_FORMAT(<Column1>, '%Y-%m-%d');
SELECT DATE_FORMAT(<Column1>, '%Y-%m-%d %H:%i:%S');
```

DATE Exsample

|Note                            |SQL                                                                    |
| :----------------------------- | :-------------------------------------------------------------------- |
|yesterday                       |SELECT DATE_ADD(CURDATE(), INTERVAL -1 DAY);                           |
|tomorrow                        |SELECT DATE_ADD(CURDATE(), INTERVAL 1 DAY);                            |
|the first of the previous month |SELECT DATE_FORMAT(ADDDATE(CURDATE(), INTERVAL -1 MONTH), '%Y-%m-01'); |
|the first of the now month      |SELECT DATE_FORMAT(CURDATE(), '%Y-%m-01');                             |
|the first of the next month     |SELECT DATE_FORMAT(ADDDATE(CURDATE(), INTERVAL 1 MONTH), '%Y-%m-01');  |
|the end of the previous month   |SELECT LAST_DAY(ADDDATE(CURDATE(), INTERVAL -1 MONTH));                |
|the end of the now month        |SELECT LAST_DAY(CURDATE());                                            |
|the end of the next month       |SELECT LAST_DAY(ADDDATE(CURDATE(), INTERVAL 1 MONTH));                 |

## FUNCTION

GROUP_CONCAT  
Require 2nd parameter at IFNULL.If max or min, check "Max/Min". And check 'group_concat_max_len'.
```sql
SELECT <tab1>.<UniqueColumn1> [, <tab1>.<UniqueColumn2> ],
GROUP_CONCAT([DISTINCT] CONCAT(IFNULL(<tab1>.<Column1>, ''), '_',IFNULL(<tab1>.<Column1>, '')) ORDER BY <tab1>.<Column1> ASC SEPARATOR '|') AS table_info
FROM <Table1> AS <tab1>
GROUP BY <tab1>.<UniqueColumn1> [, <tab1>.<UniqueColumn2> ];

SHOW VARIABLES LIKE 'group_concat_max_len';

SET SESSION group_concat_max_len = 2048;
```

MATH FUNCTION IF
```sql
SELECT <tab1>.<UniqueColumn1>(, <tab1>.<UniqueColumn2>),
SUM(IF(<tab1>.<Condition>, <true>, <false=default>)) AS sum_a,
SUM(IF(<tab1>.<Condition>, <true>, <false=default>)) AS sum_b
FROM <Table1> AS <tab1>
GROUP BY <tab1>.<UniqueColumn1>(, <tab1>.<UniqueColumn2>);
```

COUNT - MAX
```sql
SELECT <tab1>.<Column1>, COUNT(*) AS count
FROM <Table1> AS <tab1>
GROUP BY <tab1>.<Column1>
HAVING count >= (
    SELECT MAX(<having_tab>.count)
    FROM (
        SELECT COUNT(*) AS count
        FROM <Table1> AS <having_sub_tab>
        GROUP BY <having_sub_tab>.<Column1> ) AS <having_tab> );
```

SUBSTRING - REVERSE
```sql
SELECT SUBSTRING(12345, -2, 2);
 > 45

SELECT REVERSE(SUBSTRING(12345, -2, 2));
 > 54
```

TRIM
```sql
SELECT TRIM(LEADING  '　' FROM '　I　love　Vim　');
SELECT TRIM(TRAILING '　' FROM '　I　love　Vim　');
SELECT TRIM('_' FROM '_I_love_Vim_');
SELECT TRIM(' I love Vim ');
```

Comma list string search1(MySQL Only)
```sql
ex) 11 search

SELECT FIND_IN_SET(11, '1,2,11');
```

Pipe list string search(MySQL Only)
```sql
ex) 11 search

SELECT FIND_IN_SET(11, REPLACE('1|2|11', '|', ','));
```

Comma list string search2(MySQL Only?)
```sql
ex) 11 search

SELECT <tab1>.* FROM <Table1> AS <tab1> WHERE <tab1>.<Column1> REGEXP '[[:<:]]11[[:>:]]';
```

Comma list string search3
```sql
ex) 11 search

SELECT <tab1>.* FROM <Table1> AS <tab1> WHERE CONCAT(',', <tab1>.<Column1>, ',') LIKE CONCAT('%,', 11, ',%');
```

DELETE CRLF or CR or LF  
TODO:meta words.
```sql
SELECT <tab1>.<Column1> FROM <Table1> AS <tab1> WHERE <tab1>.<Column1> LIKE '%\r%' OR <tab1>.<Column1> LIKE '%\n%';

BEGIN;
UPDATE <Table1> SET <Column1> = REPLACE(REPLACE(<Column1>, '\n', ''), '\r', '') WHERE <Column1> LIKE '%\r%' OR <Column1> LIKE '%\n%';

SELECT <tab1>.<Column1> FROM <Table1> AS <tab1> WHERE <tab1>.<Column1> LIKE '%\r%' OR <tab1>.<Column1> LIKE '%\n%';
SELECT <tab1>.<UniqueColumn1>, <tab1>.<Column1> FROM <Table1> AS <tab1> WHERE <tab1>.<UniqueColumn1> IN (...);


COMMIT;
```

## Other

transaction
```sql
BEGIN;
COMMIT;
ROLLBACK;
```

Performance
```sql
EXPLAIN
SELECT ...

SHOW WARNINGS;
```

[Max/Min](http://nippondanji.blogspot.jp/2009/05/mysql.html) and [Storage Required Rule for MySQL5.7](http://dev.mysql.com/doc/refman/5.7/en/storage-requirements.html)

| Data Type                              | MIN                                                                 | MAX                                                                 | Storage Required |
| :------------------------------------- | ------------------------------------------------------------------: | ------------------------------------------------------------------: | :--------------- |
| CHAR                                   | 0                                                                   | 255(文字)                                                           | M × w bytes, 0 <= M <= 255, where w is the number of bytes required for the maximum-length character in the character set.<br />See [Section 14.2.15.7, "Physical Row Structure"](http://dev.mysql.com/doc/refman/5.7/en/innodb-physical-record.html) for information about CHAR data type storage requirements for InnoDB tables. |
| VARCHAR                                | 0                                                                   | 65535(文字)                                                         | L + 1 bytes if column values require 0 – 255 bytes<br />L + 2 bytes if values may require more than 255 bytes<br /><br />日本語の4バイト文字のため、255/4 = 63.75、VARCHAR(63)がベター |
| BLOB                                   | 0                                                                   | 64(KB)                                                              | L + 2 bytes, where L < 216 |
| TINYBLOB                               | 0                                                                   | 256(B)                                                              | L + 1 bytes, where L < 28  |
| MEDIUMBLOB                             | 0                                                                   | 16(MB)                                                              | L + 3 bytes, where L < 224 |
| LONGBLOB                               | 0                                                                   | 4(GB)                                                               | L + 4 bytes, where L < 232 |
| INT                                    | -2147483648                                                         | 2147483647                                                          | 4 bytes |
| INT UNSIGNED                           | 0                                                                   | 4294967295                                                          | 4 bytes |
| TINYINT                                | -127                                                                | 128                                                                 | 1 byte  |
| TINYINT UNSIGNED                       | 0                                                                   | 255                                                                 | 1 byte  |
| SMALLINT                               | -32768                                                              | 32767                                                               | 2 bytes |
| SMALLINT UNSIGNED                      | 0                                                                   | 65535                                                               | 2 bytes |
| MEDIUMINT                              | -8388608                                                            | 8388607                                                             | 3 bytes |
| MEDIUMINT UNSIGNED                     | 0                                                                   | 16777215                                                            | 3 bytes |
| BIGINT                                 | -9223372036854775808                                                | 9223372036854775807                                                 | 8 bytes |
| BIGINT UNSIGNED                        | 0                                                                   | 18446744073709551615                                                | 8 bytes |
| FLOAT<br />(単精度<br />浮動小数点数)  | -3.402823466E<br />+38                                              | 3.402823466E<br />+38                                               | 4 bytes |
| DOUBLE<br />(倍精度<br />浮動小数点数) | -1.7976931348623157E<br />+308                                      | 1.7976931348623157E<br />+308                                       | 8 bytes |
| DECIMAL<br />([アンパック浮動小数点数](http://nippondanji.blogspot.jp/2009/05/mysql.html))|                  |                                                                     |         |
| DATE                                   | 1000-01-01                                                          | 9999-12-31                                                          |3 bytes  |
| DATETIME                               | 1000-01-01 00:00:00                                                 | 9999-12-31 23:59:59                                                 |5 bytes + fractional seconds storage |

