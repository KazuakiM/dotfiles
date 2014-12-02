title: MySQL
==========
date: 2014-12-01 11:05
tags: []
categories: []
- - -

# Tips

Copy database
```
$ mysql -u<Account> -h<Host> -p -e "
CREATE DATABASE <New DataBase>;
"
$ mysqldump -u<Account> -h<Host> -p <DataBase1> | \
  mysql -u<Account> -h<Host> -p <New DataBase>
```
Copy table
```
$ mysql -u<Account> -h<Host> -p <DataBase1> -e "
CREATE TABLE <New Table1> LIKE          <Table1>;
INSERT INTO  <New Table1> SELECT * FROM <Table1>;
```
Check status database
```
SHOW PROCESSLIST;
SHOW FULL PROCESSLIST;

KILL xxxx;
```
PARTITIONS
```
SELECT TABLE_SCHEMA, TABLE_NAME, PARTITION_NAME, PARTITION_ORDINAL_POSITION, TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_SCHEMA = DATABASE()
AND TABLE_NAME = <Table1>;

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
  (<ColumnsData1>, <ColumnsData2>, ...),
  (<ColumnsData1>, <ColumnsData2>, ...);
```
(Bulk )Insert
```
INSERT INTO <Table1> (<Columns1>, <Columns2>, ...) VALUES
  (<ColumnsData1>, <ColumnsData2>, ...),
  (<ColumnsData1>, <ColumnsData2>, ...);
```
Insert duplicate key update
```
INSERT INTO <Table1> (<Columns1>, <Columns2>, ...) VALUES
  (<ColumnsData1>, <ColumnsData2>, ...)
ON DUPLICATE KEY UPDATE <Columns2> = <ColumnsData2>, <Columns3> = <ColumnsData3>;
```

# UPDATE

Bad
```
UPDATE <Table1> SET <Columns1> = <ColumnsData1> WHERE <UniqueColumns1> = <UniqueColumnsData1>;
UPDATE <Table1> SET <Columns1> = <ColumnsData2> WHERE <UniqueColumns1> = <UniqueColumnsData2>;
```
[Good1](http://d.hatena.ne.jp/knowledgetree/20100325/1269530022)
```
UPDATE <Table1> SET
  <Columns1> =
    CASE <UniqueColumns1>
    WHEN <UniqueColumnsData1> THEN <ColumnsData1>
    WHEN <UniqueColumnsData2> THEN <ColumnsData2>
    END
WHERE <UniqueColumns1> IN (1,2);
```
[Good2](http://qiita.com/masuidrive/items/0671ea7efa91a99c0268)
```
CREATE TEMPORARY TABLE tmp_table(<UniqueColumns1>, <Columns1>, ...);

INSERT INTO tmp_table(tbl1_id,body) VALUES
  (<UniqueColumnsData1>, <ColumnsData1>),
  (<UniqueColumnsData2>, <ColumnsData2>);

UPDATE <Table1>
  INNER JOIN tmp_table
  ON <Table1>.<UniqueColumns1> = tmp_table.<UniqueColumns1>
  SET <Table1>.<Columns1> = tmp_table.<UniqueColumns1>;
```

# DELETE/TRUNCATE

Delete
```
DELETE FROM <Table1> WHERE <Columns1> = <ColumnsData1>;
```
Truncate
```
TRUNCATE TABLE <Table1>;
```

# SELECT

Search using Columns
```
SELECT ISC.TABLE_NAME,
  ISC.COLUMN_NAME,
  ISC.COLUMN_TYPE,
  ISC.IS_NULLABLE,
  ISC.COLUMN_KEY,
  ISC.EXTRA
  FROM INFORMATION_SCHEMA.COLUMNS ISC
  WHERE ISC.TABLE_SCHEMA = <DataBase>
  AND ISC.COLUMN_NAME = <Columns1>;
```
Show using database
```
SELECT DATABASE();
```
Show empty min id
```
SELECT MIN(TAB.<Columns1> + 1) AS min_<Columns1>
FROM <Table1> TAB
WHERE NOT EXISTS (
  SELECT SUB_TAB.<Columns1>
  FROM <Table1> SUB_TAB
  WHERE (TAB.<Columns1> + 1) = SUB_TAB.<Columns1>);
```

# SHOW

Index
```
SHOW INDEX FROM <Table1>;
```
Databases
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

Database
```
CREATE DATABASE <DataBase1>;
```

# DROP

Table
```
DROP TABLE <Table1>;
```
Database
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
ALTER TABLE <Table1> DROP <Columns1>;
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

