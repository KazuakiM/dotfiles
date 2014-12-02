title: MySQL
==========
date: 2014-12-01 11:05
tags: []
categories: []
- - -

# Tips

Copy DataBase
```
$ mysqldump -u<Account> -h<Host> -p <DataBase1>    > '/tmp/<dumpFile>'
$ mysql     -u<Account> -h<Host> -p <New DataBase> < '/tmp/<dumpFile>'
```
Copy Table
```
$ mysql -u<Account> -h<Host> -p -e "
CREATE TABLE <DataBase1>.<New Table1>     LIKE         <DataBase1>.<Table1>;
INSERT INTO  <New DataBase>.<New Table1> SELECT * FROM <New DataBase>.<Table1>;
"
```
Check status DataBase
```
SHOW PROCESSLIST;
SHOW FULL PROCESSLIST;

KILL xxxx;
```
PARTITIONS
```
SELECT ISP.TABLE_SCHEMA, ISP.TABLE_NAME, ISP.PARTITION_NAME, ISP.PARTITION_ORDINAL_POSITION, ISP.TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS ISP
WHERE ISP.TABLE_SCHEMA = DATABASE()
AND ISP.TABLE_NAME = <Table1>;

SHOW CREATE TABLE <Table1>\G
```

# Import File

CUI
```
$ ls
  <dumpFile>
$ mysql -u<Account> -h<Host> -p <DataBase>  < ./<dumpFile>
```
Command
```
$ ls
  <dumpFile>
$ mysql -u<Account> -h<Host> -p <DataBase>

<Confirm SQL>

BEGIN;
SOURCE ./<dumpFile>
<Confirm SQL>


COMMIT;
```

# Export File

Tables dump
```
$ mysqldump -u<Account> -h<Host> -p <DataBase> \
 --default-character-set=utf8 --skip-lock-tables -c -e -q -t --result-file='/tmp/<dumpFile>' --tables \
 <Table1> <Table2>;
$ cd /tmp
$ vi <dumpFile>
  Check execute results.
$ tar zcvf <dumpFile>.tar.gz <dumpFile>
```
TSV
```
$ mysql -u<Account> -h<Host> -p <DataBase> -e "
<SQL>
" > /tmp/<dumpFile>
```
CSV
```
$ mysql -u<Account> -h<Host> -p <DataBase> -e "
<SQL>
" | sed -e 's/\t/,/' > /tmp/<dumpFile>
```

# INSERT

(Bulk )All columns set
```
INSERT INTO <Table1> VALUES
  (<ColumnData1>, <ColumnData2>, ...),
  (<ColumnData1>, <ColumnData2>, ...);
```
(Bulk )Insert
```
INSERT INTO <Table1> (<Column1>, <Column2>, ...) VALUES
  (<ColumnData1>, <ColumnData2>, ...),
  (<ColumnData1>, <ColumnData2>, ...);
```
Insert duplicate key update
```
INSERT INTO <Table1> (<Column1>, <Column2>, ...) VALUES
  (<ColumnData1>, <ColumnData2>, ...)
ON DUPLICATE KEY UPDATE <Column2> = <ColumnData2>, <Column3> = <ColumnData3>;
```
Inser Select
```
INSERT INTO <Table1> (<Column1>, <Column2>, ...)
  SELECT <ColumnData1>, <ColumnData2>, ...;
```

# UPDATE

Bad
```
UPDATE <Table1> SET <Column1> = <ColumnData1> WHERE <UniqueColumn1> = <UniqueColumnData1>;
UPDATE <Table1> SET <Column1> = <ColumnData2> WHERE <UniqueColumn1> = <UniqueColumnData2>;
```
[Good1](http://d.hatena.ne.jp/knowledgetree/20100325/1269530022)
```
UPDATE <Table1> SET
  <Column1> =
    CASE <UniqueColumn1>
    WHEN <UniqueColumnData1> THEN <ColumnData1>
    WHEN <UniqueColumnData2> THEN <ColumnData2>
    END
WHERE <UniqueColumn1> IN (1,2);
```
[Good2](http://qiita.com/masuidrive/items/0671ea7efa91a99c0268)
```
CREATE TEMPORARY TABLE tmp_table(<UniqueColumn1>, <Column1>, ...);

INSERT INTO tmp_table(tbl1_id,body) VALUES
  (<UniqueColumnData1>, <ColumnData1>),
  (<UniqueColumnData2>, <ColumnData2>);

UPDATE <Table1>
  INNER JOIN tmp_table
  ON <Table1>.<UniqueColumn1> = tmp_table.<UniqueColumn1>
  SET <Table1>.<Column1> = tmp_table.<UniqueColumn1>;
```

# DELETE/TRUNCATE

Delete
```
DELETE FROM <Table1> WHERE <Column1> = <ColumnData1>;
```
Truncate
```
TRUNCATE TABLE <Table1>;
```

# SELECT

Search using Column
```
SELECT ISC.TABLE_NAME,
  ISC.COLUMN_NAME,
  ISC.COLUMN_TYPE,
  ISC.IS_NULLABLE,
  ISC.COLUMN_KEY,
  ISC.EXTRA
  FROM INFORMATION_SCHEMA.COLUMNS ISC
  WHERE ISC.TABLE_SCHEMA = DATABASE()
  AND ISC.COLUMN_NAME = <Column1>;
```
Show using DataBase
```
SELECT DATABASE();
```
Show empty min id
```
SELECT MIN(TAB.<Column1> + 1) AS min_<Column1>
FROM <Table1> TAB
WHERE NOT EXISTS (
  SELECT SUB_TAB.<Column1>
  FROM <Table1> SUB_TAB
  WHERE (TAB.<Column1> + 1) = SUB_TAB.<Column1>);
```

# SHOW

Index
```
SHOW INDEX FROM <Table1>;
```
DataBases
```
SHOE DATABASES;
```
Create tabe
```
SHOW CREATE TABLE <Table1>\G
```
Max string
```
SHOW variables LIKE 'max_allowed_packet';
```

# CREATE

DataBase
```
CREATE DATABASE <DataBase1>;
```

# DROP

Table
```
DROP TABLE <Table1>;
```
DataBase
```
DROP DATABASE <DataBase1>;
```

# ALTER

Add column
```
ALTER TABLE <Table1> ADD <Column schema> AFTER <Previous column>;
```
Modify column
```
ALTER TABLE <Table1> CHANGE <Previous column name> <Column schema>;
```
Modify column schema
```
ALTER TABLE <Table1> MODIFY <Column schema>;
```
Delete Column
```
ALTER TABLE <Table1> DROP <Column1>;
```
Delete Index
```
ALTER TABLE <Table1> DROP INDEX <Index1>;
```
Update auto_increment
```
ALTER TABLE <Table1> AUTO_INCREMENT = <AutoIncrementData>;
```

# TRANSACTION

```
BEGIN;
COMMIT;
ROLLBACK;
```

