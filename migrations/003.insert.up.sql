INSERT INTO test_schema1.table1 ("my""column", normal_column)
VALUES ('value1', 'value2');

-- Insert data into test_schema1.table2
INSERT INTO test_schema1.table2 ("user's_data", "another""one'")
VALUES ('data1', 'data2');

-- Insert data into test_schema2.table3
INSERT INTO test_schema2.table3 (normal_column)
VALUES ('value3');

-- Insert data into test_schema2.table4
INSERT INTO test_schema2.table4 ("quoted""column", "another'column")
VALUES ('quoted_value', 'another_value');

-- Insert data into test_schema3.table5
INSERT INTO test_schema3.table5 ("special""name", description)
VALUES ('special_value', 'A description');