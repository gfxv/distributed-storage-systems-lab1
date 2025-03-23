CREATE OR REPLACE PROCEDURE rename_columns_in_schema(
    IN schema_name TEXT
)
    LANGUAGE plpgsql
AS $$
DECLARE
    columns_renamed_count INTEGER := 0;
    tables_changed_count INTEGER := 0;
    cur CURSOR FOR
        SELECT table_name, column_name,
               REPLACE(REPLACE(column_name, '"', ''), '''', '') AS new_column_name
        FROM information_schema.columns
        WHERE table_schema = schema_name
          AND (column_name LIKE '%"%' OR column_name LIKE '%''%');
    rec RECORD;
    prev_table_name TEXT := '';
BEGIN
    FOR rec IN cur LOOP
            EXECUTE format(
                    'ALTER TABLE %s RENAME COLUMN %s TO %s',
                    quote_ident(schema_name) || '.' || quote_ident(rec.table_name),
                    quote_ident(rec.column_name),
                    quote_ident(rec.new_column_name)
                    );

            columns_renamed_count := columns_renamed_count + 1;

            IF rec.table_name <> prev_table_name THEN
                tables_changed_count := tables_changed_count + 1;
                prev_table_name := rec.table_name;
            END IF;
        END LOOP;

    RAISE NOTICE 'Схема: %', schema_name;
    RAISE NOTICE 'Cтолбцов переименовано: %', columns_renamed_count;
    RAISE NOTICE 'Таблиц изменено: %', tables_changed_count;
END;
$$;