USE datalab;
GO

SET NOCOUNT ON;
GO

SELECT 'cientifico_datos' AS tabla, COUNT(*) AS registros
FROM cientifico_datos
UNION ALL
SELECT 'proyecto', COUNT(*)
FROM proyecto
UNION ALL
SELECT 'dataset', COUNT(*)
FROM dataset
UNION ALL
SELECT 'experimento', COUNT(*)
FROM experimento
UNION ALL
SELECT 'modelo', COUNT(*)
FROM modelo
UNION ALL
SELECT 'metrica', COUNT(*)
FROM metrica
UNION ALL
SELECT 'participacion', COUNT(*)
FROM participacion
UNION ALL
SELECT 'uso_dataset', COUNT(*)
FROM uso_dataset;
GO