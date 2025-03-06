DROP TABLE IF EXISTS test;

CREATE TABLE test (
    id SERIAL PRIMARY KEY,
    a int,
    b int
);

INSERT INTO
    test (a, b)
VALUES
    (1, 1),
(2, 2);