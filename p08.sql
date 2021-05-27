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
CREATE INDEX idx_0 ON Productos (IDProd);
CREATE INDEX idx_1 ON Productos (Descripcion);
CREATE INDEX idx_2 ON Productos (Unidades);
CREATE INDEX idx_3 ON Productos (Costo);
CREATE INDEX idx_4 ON Productos (IDDepto);
CREATE INDEX idx_5 ON Productos ((IDDepto + Costo));

-- 5 Emp(IDEmp, Nombre, Tel, Sueldo, FechaNac)
CREATE TABLE Emp (
    IDEmp INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(25) NOT NULL,
    Tel VARCHAR(25) NOT NULL,
    Sueldo DECIMAL(10,2) NOT NULL,
    FechaNac DATE NOT NULL
);

INSERT INTO Emp(Nombre, Tel, Sueldo, FechaNac) VALUES('Daniel', '55 0000 0000', 0, '1992-11-10');

-- UPDATE statement
UPDATE Emp SET Sueldo = 1 WHERE IDEmp = 1;

-- Create logs table
CREATE TABLE logs (
    id_log INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    event_type VARCHAR(25) NOT NULL,
    user_name VARCHAR(25) NOT NULL,
    user_ip VARCHAR(25) NOT NULL,
    exec_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create on update trigger
DELIMITER //
CREATE TRIGGER update_sueldo AFTER UPDATE ON Emp
FOR EACH ROW
BEGIN  
    DECLARE user_name VARCHAR(25);
    DECLARE host_name VARCHAR(50);

    SET @user_name = (SELECT USER());
    SET @host_name = (SELECT @@hostname);

    INSERT INTO logs(event_type, user_name, user_ip) VALUES('UPDATE on Sueldo', user_name, host_name);
END;//
DELIMITER ;

DROP TRIGGER update_sueldo;

-- Create on delete trigger
DELIMITER //
CREATE TRIGGER delete_emp AFTER DELETE ON Emp
FOR EACH ROW
BEGIN  
    DECLARE user_name VARCHAR(25);
    DECLARE host_name VARCHAR(50);

    SET @user_name = (SELECT USER());
    SET @host_name = (SELECT @@hostname);

    INSERT INTO logs(event_type, user_name, user_ip) VALUES('DELETE on Emp', user_name, host_name);
END;//
DELIMITER ;