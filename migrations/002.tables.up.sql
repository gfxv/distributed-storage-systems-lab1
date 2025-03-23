CREATE TABLE test_schema1.table1
(
    id            SERIAL PRIMARY KEY,
    "my""column"  TEXT, -- 'my"column'
    normal_column TEXT
);

CREATE TABLE test_schema1.table2
(
    id              SERIAL PRIMARY KEY,
    "user's_data"   TEXT, -- 'user's_data'
    "another""one'" TEXT  -- 'another"one''
);

CREATE TABLE test_schema2.table3
(
    id            SERIAL PRIMARY KEY,
    normal_column TEXT
);

CREATE TABLE test_schema2.table4
(
    id               SERIAL PRIMARY KEY,
    "quoted""column" TEXT, -- 'quoted"column'
    "another'column" TEXT  -- 'another'column'
);

CREATE TABLE test_schema3.table5
(
    id              SERIAL PRIMARY KEY,
    "special""name" TEXT, -- 'special"name'
    description     TEXT
);