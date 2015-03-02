MySQL
===

## Tips

Copy DataBase
```bash
$ mysqldump -u<Account> -h<Host> -p <DataBase1>    > '/tmp/<dumpFile>'
$ mysql     -u<Account> -h<Host> -p <New DataBase> < '/tmp/<dumpFile>'
```

Copy Table
```sql
CREATE TABLE <New DataBase>.<New Table1> LIKE          <DataBase1>.<Table1>;
INSERT INTO  <New DataBase>.<New Table1> SELECT * FROM <DataBase1>.<Table1>;
```

Slave or Master  
Slave is shown at infomation. Master is empty. 
```sql
SHOW SLAVE STATUS\G
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
 --default-character-set=utf8 --skip-lock-tables -c -e -q -t --result-file='/tmp/<dumpFile>' --tables \
 <Table1> <Table2>;
$ cd /tmp
$ vi <dumpFile>
  Check execute results.
$ tar zcvf <dumpFile>.tar.gz <dumpFile>
```

Recode dump
```bash
$ mysqldump -u<Account> -h<Host> -p <DataBase> \
 --where='<Condition>' \
 --default-character-set=utf8 --skip-lock-tables -c -e -q -t --result-file='/tmp/<dumpFile>' --tables \
 <Table1> <Table2>;
$ vi /tmp/<dumpFile>
  Check execute results.
```

TSV
```bash
$ mysql -u<Account> -h<Host> -p <DataBase> -e "
<SQL>
" > /tmp/<dumpFile>
```

CSV
```bash
$ mysql -u<Account> -h<Host> -p <DataBase> -e "
<SQL>
" | sed -e 's/\t/,/' > /tmp/<dumpFile>
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

ALTER TABLE view_log ADD PARTITION (
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

Bad
```sql
UPDATE <Table1> SET <Column1> = <ColumnData1> WHERE <UniqueColumn1> = <UniqueColumnData1>;
UPDATE <Table1> SET <Column1> = <ColumnData2> WHERE <UniqueColumn1> = <UniqueColumnData2>;
```

[Good1](http://d.hatena.ne.jp/knowledgetree/20100325/1269530022)
```sql
UPDATE <Table1> SET
  <Column1> =
    CASE <UniqueColumn1>
    WHEN <UniqueColumnData1> THEN <ColumnData1>
    WHEN <UniqueColumnData2> THEN <ColumnData2>
    END
WHERE <UniqueColumn1> IN (1,2);
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

## DELETE/TRUNCATE

Delete
```sql
DELETE FROM <Table1> WHERE <Column1> = <ColumnData1>;
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
FROM <Table1> TAB
WHERE NOT EXISTS (
  SELECT SUB_TAB.<Column1>
  FROM <Table1> SUB_TAB
  WHERE (TAB.<Column1> + 1) = SUB_TAB.<Column1>);
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

## DROP

Table
```sql
DROP TABLE <Table1>;
```

DataBase
```sql
DROP DATABASE <DataBase1>;
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
ex) now :389, next_increment:391 => increment:390. 

SELECT MAX(id) AS max_num FROM <Table1>\G

   MAX(id): 389

SHOW TABLE STATUS LIKE <Table1>\G

   Auto_increment: 391

ALTER TABLE <Table1> AUTO_INCREMENT = 390;
```

## FUNCTION

GROUP_CONCAT  
Require 2nd parameter at IFNULL.If max or min, check "Max/Min". And check 'group_concat_max_len'.
```sql
SELECT <UniqueColumn1>(, <UniqueColumn2>),
  GROUP_CONCAT(CONCAT(IFNULL(<Column1>, ''), '_',IFNULL(<Column1>, '')) ORDER BY <Column1> ASC SEPARATOR '|') AS table_info
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

UTC+9(Japanese timezone)
```sql
SELECT DATE_ADD(NOW(), INTERVAL 9 hour);
```

DATE_FORMAT
```sql
SELECT DATE_FORMAT(<Column1>, '%Y-%m-%d');
SELECT DATE_FORMAT(<Column1>, '%Y-%m-%d %H:%i:%S');
```

TRIM
```sql
SELECT TRIM(LEADING  '　' FROM '　I　love　Vim　');
SELECT TRIM(TRAILING '　' FROM '　I　love　Vim　');
SELECT TRIM('_' FROM '_I_love_Vim_');
SELECT TRIM(' I love Vim ');
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

[Max/Min](http://nippondanji.blogspot.jp/2009/05/mysql.html)

| Type               | MIN                                                                 | MAX                                                                 |
| :----------------- | ------------------------------------------------------------------: | ------------------------------------------------------------------: |
| CHAR               | 0                                                                   | 255(文字)                                                           |
| VARCHAR            | 0                                                                   | 65535(文字)                                                         |
| BLOB               | 0                                                                   | 64(KB)                                                              |
| TINYBLOB           | 0                                                                   | 256(B)                                                              |
| MEDIUMBLOB         | 0                                                                   | 16(MB)                                                              |
| LONGBLOB           | 0                                                                   | 4(GB)                                                               |
| INT                | -2147483648                                                         | 2147483647                                                          |
| INT UNSIGNED       | 0                                                                   | 4294967295                                                          |
| TINYINT            | -127                                                                | 128                                                                 |
| TINYINT UNSIGNED   | 0                                                                   | 255                                                                 |
| SMALLINT           | -32768                                                              | 32767                                                               |
| SMALLINT UNSIGNED  | 0                                                                   | 65535                                                               |
| MEDIUMINT          | -8388608                                                            | 8388607                                                             |
| MEDIUMINT UNSIGNED | 0                                                                   | 16777215                                                            |
| BIGINT             | -9223372036854775808                                                | 9223372036854775807                                                 |
| BIGINT UNSIGNED    | 0                                                                   | 18446744073709551615                                                |
| DECIMAL            | [小数点が扱える](http://nippondanji.blogspot.jp/2009/05/mysql.html) | [小数点が扱える](http://nippondanji.blogspot.jp/2009/05/mysql.html) |
| DATETIME           | 1000-01-01 00:00:00                                                 | 9999-12-31 23:59:59                                                 |
| TIMESTAMP          | 1970-01-01 00:00:01                                                 | 2038-01-09 03:14:07(UTC)                                            |

