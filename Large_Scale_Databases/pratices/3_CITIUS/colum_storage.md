## [Columnar Storage](https://docs.citusdata.com/en/v10.1/admin_guide/table_management.html#columnar-storage)

Citus 10 introduces append-only columnar table storage for analytic and data warehousing workloads. When columns (rather than rows) are stored contiguously on disk, data becomes more compressible, and queries can request a subset of columns more quickly.
Usage

To use columnar storage, specify USING columnar when creating a table:

```sql
CREATE TABLE contestant (
    handle TEXT,
    birthdate DATE,
    rating INT,
    percentile FLOAT,
    country CHAR(3),
    achievements TEXT[]
) USING columnar;

-- You can also convert between row-based (heap) and columnar storage.

-- Convert to row-based (heap) storage
SELECT alter_table_set_access_method('contestant', 'heap');

-- Convert to columnar storage (indexes will be dropped)
SELECT alter_table_set_access_method('contestant', 'columnar');
```
Citus converts rows to columnar storage in “stripes” during insertion. Each stripe holds one transaction’s worth of data, or 150000 rows, whichever is less. (The stripe size and other parameters of a columnar table can be changed with the alter_columnar_table_set function.)

For example, the following statement puts all five rows into the same stripe, because all values are inserted in a single transaction:
```sql 
-- insert these values into a single columnar stripe

INSERT INTO contestant VALUES
  ('a','1990-01-10',2090,97.1,'XA','{a}'),
  ('b','1990-11-01',2203,98.1,'XA','{a,b}'),
  ('c','1988-11-01',2907,99.4,'XB','{w,y}'),
  ('d','1985-05-05',2314,98.3,'XB','{}'),
  ('e','1995-05-05',2236,98.2,'XC','{a}');
```
It’s best to make large stripes when possible, because Citus compresses columnar data separately per stripe. We can see facts about our columnar table like compression rate, number of stripes, and average rows per stripe by using VACUUM VERBOSE:
```sql
VACUUM VERBOSE contestant;

INFO:  statistics for "contestant":
storage id: 10000000000
total file size: 24576, total data size: 248
compression rate: 1.31x
total row count: 5, stripe count: 1, average rows per stripe: 5
chunk count: 6, containing data for dropped columns: 0, zstd compressed: 6

The output shows that Citus used the zstd compression algorithm to obtain 1.31x data compression. The compression rate compares a) the size of inserted data as it was staged in memory against b) the size of that data compressed in its eventual stripe.

Because of how it’s measured, the compression rate may or may not match the size difference between row and columnar storage for a table. The only way truly find that difference is to construct a row and columnar table that contain the same data, and compare.
Measuring compression

Let’s create a new example with more data to benchmark the compression savings.

-- first a wide table using row storage
CREATE TABLE perf_row(
  c00 int8, c01 int8, c02 int8, c03 int8, c04 int8, c05 int8, c06 int8, c07 int8, c08 int8, c09 int8,
  c10 int8, c11 int8, c12 int8, c13 int8, c14 int8, c15 int8, c16 int8, c17 int8, c18 int8, c19 int8,
  c20 int8, c21 int8, c22 int8, c23 int8, c24 int8, c25 int8, c26 int8, c27 int8, c28 int8, c29 int8,
  c30 int8, c31 int8, c32 int8, c33 int8, c34 int8, c35 int8, c36 int8, c37 int8, c38 int8, c39 int8,
  c40 int8, c41 int8, c42 int8, c43 int8, c44 int8, c45 int8, c46 int8, c47 int8, c48 int8, c49 int8,
  c50 int8, c51 int8, c52 int8, c53 int8, c54 int8, c55 int8, c56 int8, c57 int8, c58 int8, c59 int8,
  c60 int8, c61 int8, c62 int8, c63 int8, c64 int8, c65 int8, c66 int8, c67 int8, c68 int8, c69 int8,
  c70 int8, c71 int8, c72 int8, c73 int8, c74 int8, c75 int8, c76 int8, c77 int8, c78 int8, c79 int8,
  c80 int8, c81 int8, c82 int8, c83 int8, c84 int8, c85 int8, c86 int8, c87 int8, c88 int8, c89 int8,
  c90 int8, c91 int8, c92 int8, c93 int8, c94 int8, c95 int8, c96 int8, c97 int8, c98 int8, c99 int8
);

-- next a table with identical columns using columnar storage
CREATE TABLE perf_columnar(LIKE perf_row) USING COLUMNAR;

Fill both tables with the same large dataset:

INSERT INTO perf_row
  SELECT
    g % 00500, g % 01000, g % 01500, g % 02000, g % 02500, g % 03000, g % 03500, g % 04000, g % 04500, g % 05000,
    g % 05500, g % 06000, g % 06500, g % 07000, g % 07500, g % 08000, g % 08500, g % 09000, g % 09500, g % 10000,
    g % 10500, g % 11000, g % 11500, g % 12000, g % 12500, g % 13000, g % 13500, g % 14000, g % 14500, g % 15000,
    g % 15500, g % 16000, g % 16500, g % 17000, g % 17500, g % 18000, g % 18500, g % 19000, g % 19500, g % 20000,
    g % 20500, g % 21000, g % 21500, g % 22000, g % 22500, g % 23000, g % 23500, g % 24000, g % 24500, g % 25000,
    g % 25500, g % 26000, g % 26500, g % 27000, g % 27500, g % 28000, g % 28500, g % 29000, g % 29500, g % 30000,
    g % 30500, g % 31000, g % 31500, g % 32000, g % 32500, g % 33000, g % 33500, g % 34000, g % 34500, g % 35000,
    g % 35500, g % 36000, g % 36500, g % 37000, g % 37500, g % 38000, g % 38500, g % 39000, g % 39500, g % 40000,
    g % 40500, g % 41000, g % 41500, g % 42000, g % 42500, g % 43000, g % 43500, g % 44000, g % 44500, g % 45000,
    g % 45500, g % 46000, g % 46500, g % 47000, g % 47500, g % 48000, g % 48500, g % 49000, g % 49500, g % 50000
  FROM generate_series(1,50000000) g;

INSERT INTO perf_columnar
  SELECT
    g % 00500, g % 01000, g % 01500, g % 02000, g % 02500, g % 03000, g % 03500, g % 04000, g % 04500, g % 05000,
    g % 05500, g % 06000, g % 06500, g % 07000, g % 07500, g % 08000, g % 08500, g % 09000, g % 09500, g % 10000,
    g % 10500, g % 11000, g % 11500, g % 12000, g % 12500, g % 13000, g % 13500, g % 14000, g % 14500, g % 15000,
    g % 15500, g % 16000, g % 16500, g % 17000, g % 17500, g % 18000, g % 18500, g % 19000, g % 19500, g % 20000,
    g % 20500, g % 21000, g % 21500, g % 22000, g % 22500, g % 23000, g % 23500, g % 24000, g % 24500, g % 25000,
    g % 25500, g % 26000, g % 26500, g % 27000, g % 27500, g % 28000, g % 28500, g % 29000, g % 29500, g % 30000,
    g % 30500, g % 31000, g % 31500, g % 32000, g % 32500, g % 33000, g % 33500, g % 34000, g % 34500, g % 35000,
    g % 35500, g % 36000, g % 36500, g % 37000, g % 37500, g % 38000, g % 38500, g % 39000, g % 39500, g % 40000,
    g % 40500, g % 41000, g % 41500, g % 42000, g % 42500, g % 43000, g % 43500, g % 44000, g % 44500, g % 45000,
    g % 45500, g % 46000, g % 46500, g % 47000, g % 47500, g % 48000, g % 48500, g % 49000, g % 49500, g % 50000
  FROM generate_series(1,50000000) g;

VACUUM (FREEZE, ANALYZE) perf_row;
VACUUM (FREEZE, ANALYZE) perf_columnar;

For this data, you can see a compression ratio of better than 8X in the columnar table.

SELECT pg_total_relation_size('perf_row')::numeric/
       pg_total_relation_size('perf_columnar') AS compression_ratio;

```

 compression_ratio
--------------------
 8.0196135873627944
(1 row)

[Example](https://docs.citusdata.com/en/v10.1/use_cases/timeseries.html#columnar-example)

Columnar storage works well with table partitioning. For an example, see Archiving with Columnar Storage.


Archiving with Columnar Storage

Some applications have data that logically divides into a small updatable part and a larger part that’s “frozen.” Examples include logs, clickstreams, or sales records. In this case we can combine partitioning with columnar table storage (introduced in Citus 10) to compress historical partitions on disk. Citus columnar tables are currently append-only, meaning they do not support updates or deletes, but we can use them for the immutable historical partitions.

A partitioned table may be made up of any combination of row and columnar partitions. When using range partitioning on a timestamp key, we can make the newest partition a row table, and periodically roll the newest partition into another historical columnar partition.

Let’s see an example, using GitHub events again. We’ll create a new table called github.columnar_events for disambiguation from the earlier example. We’ll manage its partitions manually. To focus entirely on the columnar storage aspect, we won’t distribute this table.

CREATE TABLE github.columnar_events ( LIKE github.events )
PARTITION BY RANGE (created_at);

```sql 
-- create partitions to hold two hours of data each

-- columnar partitions for historical data
CREATE TABLE ge0 PARTITION OF github.columnar_events
  FOR VALUES FROM ('2015-01-01 00:00:00') TO ('2015-01-01 02:00:00')
  USING columnar;
CREATE TABLE ge1 PARTITION OF github.columnar_events
  FOR VALUES FROM ('2015-01-01 02:00:00') TO ('2015-01-01 04:00:00')
  USING columnar;
CREATE TABLE ge2 PARTITION OF github.columnar_events
  FOR VALUES FROM ('2015-01-01 04:00:00') TO ('2015-01-01 06:00:00')
  USING columnar;

-- row partition for latest data
CREATE TABLE ge3 PARTITION OF github.columnar_events
  FOR VALUES FROM ('2015-01-01 06:00:00') TO ('2015-01-01 08:00:00');
```
Next, download sample data:

wget http://examples.citusdata.com/github_archive/github_events-2015-01-01-{0..5}.csv.gz
gzip -d github_events-2015-01-01-*.gz

And load it (note that this data requires the database to have UTF8 encoding):

```sql
\COPY github.columnar_events FROM 'github_events-2015-01-01-1.csv' WITH (format CSV)
\COPY github.columnar_events FROM 'github_events-2015-01-01-2.csv' WITH (format CSV)
\COPY github.columnar_events FROM 'github_events-2015-01-01-3.csv' WITH (format CSV)
\COPY github.columnar_events FROM 'github_events-2015-01-01-4.csv' WITH (format CSV)
\COPY github.columnar_events FROM 'github_events-2015-01-01-5.csv' WITH (format CSV)
```
To see the compression ratio for a columnar table, use VACUUM VERBOSE. The compression ratio for our three columnar partitions is pretty good:

VACUUM VERBOSE github.columnar_events;

INFO:  statistics for "ge0":
storage id: 10000000004
total file size: 2179072, total data size: 2149126
compression rate: 8.50x
total row count: 7427, stripe count: 1, average rows per stripe: 7427
chunk count: 9, containing data for dropped columns: 0, zstd compressed: 9

INFO:  statistics for "ge1":
storage id: 10000000005
total file size: 3579904, total data size: 3543869
compression rate: 8.27x
total row count: 12714, stripe count: 2, average rows per stripe: 6357
chunk count: 18, containing data for dropped columns: 0, zstd compressed: 18

INFO:  statistics for "ge2":
storage id: 10000000006
total file size: 2949120, total data size: 2910929
compression rate: 8.53x
total row count: 11756, stripe count: 2, average rows per stripe: 5878
chunk count: 18, containing data for dropped columns: 0, zstd compressed: 18

One power of the partitioned table github.columnar_events is that it can be queried in its entirety like a normal table.
```sql
SELECT COUNT(DISTINCT repo_id)
  FROM github.columnar_events;
```

 count
-------
 13306

Entries can be updated or deleted, as long as there’s a WHERE clause on the partition key which filters entirely into row table partitions.
