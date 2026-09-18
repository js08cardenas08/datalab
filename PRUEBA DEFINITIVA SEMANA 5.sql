USE datalab;

-- ---------------------------------------------------------
-- Prueba 1 — Inserciones válidas (deben funcionar sin error)
-- ---------------------------------------------------------

INSERT INTO cientifico_datos (nombre, correo_institucional)
VALUES ('Ana Torres', 'ana.torres@usta.edu.co');

INSERT INTO proyecto (nombre_proyecto, descripcion)
VALUES ('Detección de fraude en transacciones', 'Modelo de clasificación binaria sobre transacciones bancarias');                

USE datalab;

INSERT INTO experimento (id_proyecto, id_cientifico, configuracion) 
VALUES (999, 1, 'lr=0.01;epochs=50;batch=32');

USE datalab;

INSERT INTO experimento (id_proyecto, id_cientifico, configuracion) 
VALUES (1, 1, 'lr=0.01;epochs=50;batch=32');

INSERT INTO modelo (id_experimento, nombre, version, algoritmo) 
VALUES (1, 'modelo_fraude_v1', '1.0', 'Random Forest');  

SELECT * FROM experimento;                                
SELECT * FROM experimento;
INSERT INTO modelo (id_experimento, nombre, version, algoritmo) 
VALUES (2, 'modelo_fraude_v1', '1.0', 'Random Forest');      

INSERT INTO metrica (id_modelo, nombre_metrica, valor, fecha_calculo) 
VALUES (1, 'accuracy', 1.5, CURDATE());     

DELETE FROM proyecto
WHERE id_proyecto = 1;                      