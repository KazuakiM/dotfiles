MySQL
===

## ER Diagram

ALL DB
* [Windows only](http://www.wind.sannet.ne.jp/m_matsu/developer/a5m2/)

MySQL
* [MySQL Workbench](http://dev.mysql.com/downloads/workbench/)

## Tips

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

Slave or Master  
Slave is shown at infomation. Master is empty.
```sql
SHOW MASTER STATUS\G
SHOW SLAVE  STATUS\G
```

[Trouble](http://qiita.com/muran001/items/14f19959d4723ffc29cc)
```sql
SHOW GLOBAL STATUS;
SHOW PROCESSLIST;
SHOW FULL PROCESSLIST;

KILL xxxx;
```

CSV to SQL  
'\47' is SingleQuote.
```bash
$ awk -F "," '{print "INSERT INTO <Table1> (<Column1>, <Column2>, ...) VALUES ("$1",\047"$2"\047,...);"}' <dumpFile>.csv > /tmp/<dumpFile>.sql
$ sed -i -e s/\'NULL\'/NULL/ /tmp/<dumpFile>.sql
```

DELETE CRLF or CR or LF  
TODO:meta words.
```sql
SELECT <Column1> FROM <Table1> WHERE <Column1> LIKE '%\r\n%' OR <Column1> LIKE '%\r%' OR <Column1> LIKE '%\n%';

BEGIN;
UPDATE <Table1> SET <Column1> = REPLACE(<Column1>, '\r\n', '') WHERE <Column1> LIKE '%\r\n%';
UPDATE <Table1> SET <Column1> = REPLACE(<Column1>, '\n',   '') WHERE <Column1> LIKE '%\n%';
UPDATE <Table1> SET <Column1> = REPLACE(<Column1>, '\r',   '') WHERE <Column1> LIKE '%\r%';

SELECT <Column1> FROM <Table1> WHERE <Column1> LIKE '%\r\n%' OR <Column1> LIKE '%\r%' OR <Column1> LIKE '%\n%';
SELECT <UniqueColumn1>, <Column1> FROM <Table1> WHERE <UniqueColumn1> IN (...);


COMMIT;
```

## Import File

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

## Export File

Tables dump
```bash
$ mysqldump -u<Account> -h<Host> -p <DataBase> \
 --default-character-set=utf8 --single-transaction --skip-lock-tables -c -e -q -t --result-file='/tmp/<dumpFile>.dump' --tables \
 <Table1> <Table2>;
$ vi /tmp/<dumpFile>.dump
  Check execute results.
$ cd /tmp
$ tar zcvf <dumpFile>.dump.tar.gz <dumpFile>.dump
```

Recode dump
```bash
$ mysqldump -u<Account> -h<Host> -p <DataBase> \
 --where='<Condition>' \
 --default-character-set=utf8 --single-transaction --skip-lock-tables -c -e -q -t --result-file='/tmp/<dumpFile>.dump' --tables \
 <Table1> <Table2>;
$ vi /tmp/<dumpFile>.dump
  Check execute results.
```

1 table Recode dump(TABLE JOIN)
```bash
$ mysqldump -u<Account> -h<Host> -p <DataBase> \
 --where='id IN (SELECT <T1>.id FROM <Table1> <T1> INNER JOIN <Table2> <T2> ON <T1>.id = <T2>.t1_id WHERE <T2>.status = 1)' \
 --default-character-set=utf8 --single-transaction --skip-lock-tables -c -e -q -t --result-file='/tmp/<dumpFile>.dump' --tables \
 <Table1>;
$ vi /tmp/<dumpFile>.dump
  Check execute results.
```

TSV
```bash
$ cd /tmp
$ mysql -u<Account> -h<Host> -p <DataBase> -e "
<SQL>
" > <dumpFile>.tsv && tar zcvf <dumpFile>.tsv.tar.gz <dumpFile>.tsv && rm -f <dumpFile>.tsv
```

CSV
```bash
$ cd /tmp
$ mysql -u<Account> -h<Host> -p <DataBase> -e "
<SQL>
" | sed -e 's/\t/,/' > <dumpFile>.csv && tar zcvf <dumpFile>.csv.tar.gz <dumpFile>.csv && rm -f <dumpFile>.csv
```
## PARTITIONS

Check partitions
```sql
SELECT ISP.TABLE_SCHEMA, ISP.TABLE_NAME, ISP.PARTITION_NAME, ISP.PARTITION_ORDINAL_POSITION, ISP.TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS ISP WHERE ISP.TABLE_SCHEMA = DATABASE() AND ISP.PARTITION_NAME IS NOT NULL ORDER BY ISP.TABLE_NAME ASC, ISP.PARTITION_NAME ASC;
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
  PARTITION p201401 VALUES LESS THAN ('2014-02-01') ENGINE = InnoDB,
  PARTITION p201402 VALUES LESS THAN ('2014-03-01') ENGINE = InnoDB);

SHOW CREATE TABLE <Table1>;
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
  SELECT <ColumnData1>, <ColumnData2>, ...
  FROM <Table2>
  ORDER BY <ColumnData1>
ON DUPLICATE KEY UPDATE
  <Column2> = IF(<Table1>.<Column1> < <Table2>.<ColumnData1>, <Table1>.<Column1>, <Table2>.<ColumnData1>),
  <Column3> = CONCAT(<Table1>.<Column3>, '_', IFNULL(<Column1>, ''));
```

[Insert select group by duplicate key update](http://stackoverflow.com/questions/16935896/mysql-on-duplicate-key-update-while-inserting-a-result-set-from-a-query)
```sql
INSERT INTO <Table1> (<Column1>, <Column2>, ...)
  SELECT <ColumnData1>, @group_column := <ColumnData2>, ...
  FROM <Table2>
  GROUP BY <ColumnData1>
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
UPDATE <Table1> AS TAB1
  INNER JOIN <Table2> AS TAB2
  ON TAB1.id = TAB2.tab1_id
  SET TAB1.<Column1> = <ColumnData1> WHERE <UniqueColumn1> = <UniqueColumnData1>;
```

[Good1](http://d.hatena.ne.jp/knowledgetree/20100325/1269530022)
```sql
UPDATE <Table1> SET
  <Column1> =
    CASE <UniqueColumn1>
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

UPDATE <Table1>
  INNER JOIN tmp_<Table1>
  ON <Table1>.<UniqueColumn1> = tmp_<Table1>.<UniqueColumn1>
  SET <Table1>.<Column1> = tmp_<Table1>.<UniqueColumn1>;
```

Multi Table
```sql
UPDATE <Table1> AS TAB1
  INNER JOIN <Table2> AS TAB2
  ON TAB1.id = TAB2.tab1_id
  SET TAB1.<Column1> = <ColumnData1>,
  TAB2.<Column2> = <ColumnData2>
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
SELECT ISC.TABLE_NAME, ISC.COLUMN_NAME, ISC.COLUMN_TYPE, ISC.IS_NULLABLE, ISC.COLUMN_KEY, ISC.EXTRA FROM INFORMATION_SCHEMA.COLUMNS ISC WHERE ISC.TABLE_SCHEMA = DATABASE()
AND ISC.COLUMN_NAME = <Column1>;
```

Show using DataBase
```sql
SELECT DATABASE();
```

Show empty min id
```sql
SELECT MIN(TAB.<Column1> + 1) AS min_<Column1>
FROM <Table1> AS TAB
WHERE NOT EXISTS (
  SELECT SUB_TAB.<Column1>
  FROM <Table1> SUB_TAB
  WHERE (TAB.<Column1> + 1) = SUB_TAB.<Column1>);
```

Range column
```sql
SELECT TAB.<Column1>
FROM <Table1> AS TAB
WHERE NOW() BETWEEN start_date AND end_date;
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
CREATE DATABASE <DataBase1>, <DataBase2>;
```

Table  
> Don't use direct CREATE TABLE commands and should use ER Diagram(check top page).

TEMPORARY TABLE - SELECT
```sql
CREATE TEMPORARY TABLE tmp_<Table1> (<Column1>, <Column2>, ...)
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

SELECT MAX(id) AS max_num FROM <Table1>\G

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
  WHEN <ColumnData1-1>  THEN <Data1-1>
  WHEN <ColumnData1-2>  THEN <Data1-2>
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
SELECT CASE
  WEHN <Column1> = <ColumnData1-1> THEN <Data1-1>
  WHEN <Column1> = <ColumnData1-2> THEN <Data1-2>
  ELSE <Data1-3>
  END AS <Column1_RENAME>
  FROM <Table1>
  GROUP BY <Column1_RENAME>
```

## DATE

UTC+9(Japanese timezone)
```sql
SELECT DATE_ADD(NOW(), INTERVAL 9 hour);
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
SELECT <UniqueColumn1>(, <UniqueColumn2>),
  GROUP_CONCAT([DISTINCT] CONCAT(IFNULL(<Column1>, ''), '_',IFNULL(<Column1>, '')) ORDER BY <Column1> ASC SEPARATOR '|') AS table_info
  FROM <Table1>
  GROUP BY <UniqueColumn1>(, <UniqueColumn2>);

SHOW VARIABLES LIKE 'group_concat_max_len';

SET SESSION group_concat_max_len = 2048;
```

MATH FUNCTION IF
```sql
SELECT <UniqueColumn1>(, <UniqueColumn2>),
  SUM(IF(<Condition>, <true>, <false=default>)) AS sum
  FROM <Table1>
  GROUP BY <UniqueColumn1>(, <UniqueColumn2>);
```

COUNT - MAX
```sql
SELECT tab.<Column1>, COUNT(*) AS count
FROM <Table1> AS tab
GROUP BY tab.<Column1>
HAVING count >= (
  SELECT MAX(having_tab.count)
  FROM (
    SELECT COUNT(*) AS count
    FROM <Table1> AS having_sub_tab
    GROUP BY having_sub_tab.<Column1> ) AS having_tab );
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

SELECT * FROM <Table1> WHERE <Column1> REGEXP '[[:<:]]11[[:>:]]';
```

Comma list string search3
```sql
ex) 11 search

SELECT * FROM <Table1> WHERE CONCAT(',', <Column1>, ',') LIKE CONCAT('%,', 11, ',%');
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
```

[Max/Min](http://nippondanji.blogspot.jp/2009/05/mysql.html) and [Storage Required Rule for MySQL5.7](http://dev.mysql.com/doc/refman/5.7/en/storage-requirements.html)

| Data Type                              | MIN                                                                 | MAX                                                                 | Storage Required |
| :------------------------------------- | ------------------------------------------------------------------: | ------------------------------------------------------------------: | :--------------- |
| CHAR                                   | 0                                                                   | 255(文字)                                                           | M × w bytes, 0 <= M <= 255, where w is the number of bytes required for the maximum-length character in the character set.<br />See [Section 14.2.15.7, "Physical Row Structure"](http://dev.mysql.com/doc/refman/5.7/en/innodb-physical-record.html) for information about CHAR data type storage requirements for InnoDB tables. |
| VARCHAR                                | 0                                                                   | 65535(文字)                                                         | L + 1 bytes if column values require 0 – 255 bytes<br />L + 2 bytes if values may require more than 255 bytes |
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
| DECIMAL<br />([アンパック<br />浮動小数点数](http://nippondanji.blogspot.jp/2009/05/mysql.html))||||
| DATE                                   | 1000-01-01                                                          | 9999-12-31                                                          |3 bytes  |
| DATETIME                               | 1000-01-01 00:00:00                                                 | 9999-12-31 23:59:59                                                 |5 bytes + fractional seconds storage |

