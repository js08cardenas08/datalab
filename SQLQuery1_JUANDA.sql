SELECT *
FROM proyecto
WHERE id_proyecto = 1;

INSERT INTO proyecto
    (nombre, descripcion)
VALUES
    ('Prediccion de demanda',
     'Proyecto para analizar y predecir la demanda de servicios.');

     SELECT *
FROM proyecto
WHERE nombre = 'Prediccion de demanda';


USE DataLab; 
GO

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'experimento';

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES

SELECT TOP 5 * FROM experimento;

-- Consulta A: usando OR
SELECT *
FROM experimento
WHERE id_proyecto = 1
   OR id_proyecto = 2;

-- Consulta B: usando IN
SELECT *
FROM experimento
WHERE id_proyecto IN (1, 2);

-- Consulta C: usando NOT IN
SELECT *
FROM experimento
WHERE id_proyecto NOT IN (1, 2);


SELECT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
ORDER BY TABLE_NAME, ORDINAL_POSITION;


SELECT id_dataset, nombre, fuente FROM dataset;

SELECT * FROM dataset
WHERE nombre LIKE 'EEG%';

SELECT * FROM dataset
WHERE nombre LIKE '%clinico';

SELECT * FROM dataset
WHERE nombre LIKE '%senal%';

SELECT * FROM dataset
WHERE nombre LIKE 'EEG_____';


SELECT COUNT(*) AS total FROM dataset;

SELECT id_dataset, nombre, fuente, fecha_carga FROM dataset;

-- 1. Nombres que comienzan por 'Trans'
SELECT * FROM dataset
WHERE nombre LIKE 'Trans%';
-- Esperado: 3 filas (ids 1, 3, 5)

-- 2. Nombres que terminan en 'activos'
SELECT * FROM dataset
WHERE nombre LIKE '%activos';
-- Esperado: 3 filas (ids 2, 4, 6)

-- 3. Nombres que contienen 'cion'
SELECT * FROM dataset
WHERE nombre LIKE '%cion%';
-- Esperado: 3 filas (Transacciones 2025)

-- 4. Patrón de longitud con _
-- "Clientes activos" tiene 16 caracteres; el _ reemplaza el espacio
SELECT * FROM dataset
WHERE nombre LIKE 'Clientes_activos';
-- Esperado: 3 filas (ids 2, 4, 6)

-- a) Datasets ordenados por nombre ascendente
SELECT * FROM dataset
ORDER BY nombre ASC;

-- b) Datasets ordenados por fecha de carga descendente
SELECT * FROM dataset
ORDER BY fecha_carga DESC;

-- c) Por fuente y, en empate, por fecha de carga descendente
SELECT * FROM dataset
ORDER BY fuente ASC, fecha_carga DESC;