# SEMANA 4

 ## 15.Auditoría de normalización del propio esquema --- 50 minutos

Revisen **tabla por tabla** su esquema real de DataLab de la Semana 3.

Utilicen la siguiente matriz:

Tabla | ¿Valores atómicos? (1FN) | ¿Sin dependencia parcial? (2FN, solo si aplica) | ¿Sin dependencia transitiva? (3FN)|
-----------|-----------|----------------|----------------|
`cientifico_datos`| Si | Si| Si |
`proyecto`| Si | Si| Si |                        
`dataset`| Si | Si| Si |                                
`experimento`| Si | Si| Si |                                 
`modelo`| Si | Si| Si |                             
`metrica`| Si | Si| Si |                                  
`participacion`| Si | Si| Si |                                 
`uso_dataset`| Si | Si| - |                           


### Para cada tabla deben preguntarse:

La mayoría de las tablas cumplen con las tres formas normales, ya que utilizan valores atómicos, claves primarias simples y no presentan dependencias transitivas evidentes. La tabla usa debe revisarse porque contiene, además de experimentos_id, las columnas experimentos_cientifico_datos_id y experimentos_proyectos_id, que aparentemente dependen del experimento y podrían representar información redundante.git