USE diplo_tarea00;
SELECT count(*) FROM Productos;

-- Create table
CREATE TABLE Productos (
    IDProd INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL,
    Unidades INT NOT NULL DEFAULT 0,
    Costo DECIMAL(5,2) NOT NULL DEFAULT 0.0,
    IDDepto INT NOT NULL
);

INSERT INTO Productos (
    IDProd,
    Descripcion,
    Unidades,
    Costo,
    IDDepto
) VALUES (1, 'desc', 1, 100, 1);


-- INSERT INTO Products STORE PROCEDURE
DELIMITER $$
CREATE PROCEDURE InsertProducts(
        IN numberOfProducts INT
    )
    BEGIN
        DECLARE i INT;
        SET i = 0;

        WHILE i<numberOfProducts DO
            INSERT INTO Productos (
                Descripcion,
                Unidades,
                Costo,
                IDDepto
            ) VALUES ('desc', 1, 100, i);

            SET i = i+1;
        END WHILE;
END$$
DELIMITER ;
-- DROP PROCEDURE InsertProducts;
-- CALL InsertProducts(700000);

-- Get table size
SELECT
  TABLE_NAME,
  DATA_LENGTH,
  INDEX_LENGTH,
  ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS `Size (MB)`
FROM
  information_schema.TABLES
WHERE TABLE_NAME='Productos';

SHOW TABLE STATUS WHERE name='Productos';

-- Create index

IDProd
Descripcion
Unidades
Costo
IDDepto

CREATE INDEX idx_0 ON Productos (IDProd);
CREATE INDEX idx_1 ON Productos (Descripcion);
CREATE INDEX idx_2 ON Productos (Unidades);
CREATE INDEX idx_3 ON Productos (Costo);
CREATE INDEX idx_4 ON Productos (IDDepto);
CREATE INDEX idx_5 ON Productos ((IDDepto + Costo));