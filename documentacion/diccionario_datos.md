# Diccionario de datos
# Diccionario de Datos — DataLab

## CIENTIFICO_DATOS

| Atributo      | Tipo de atributo | Llave           |
| ------------- | ---------------- | --------------- |
| id_cientifico | Simple           | Llave primaria  |
| nombre        | Simple           | —               |
| correo        | Simple           | Llave candidata |
| especialidad  | Simple           | —               |

## PROYECTO

| Atributo         | Tipo de atributo | Llave           |
| ---------------- | ---------------- | --------------- |
| id_proyecto      | Simple           | Llave primaria  |
| nombre           | Simple           | Llave candidata |
| problema_negocio | Simple           | —               |
| descripcion      | Simple           | —               |

## DATASET

| Atributo     | Tipo de atributo | Llave          |
| ------------ | ---------------- | -------------- |
| id_dataset   | Simple           | Llave primaria |
| nombre       | Simple           | —              |
| fuente       | Simple           | —              |
| fecha_carga  | Simple           | —              |
| tamano_filas | Simple           | —              |

## EXPERIMENTO

| Atributo               | Tipo de atributo | Llave          |
| ---------------------- | ---------------- | -------------- |
| id_experimento_interno | Simple           | Llave primaria |
| nombre_experimento     | Simple           | —              |
| fecha_ejecucion        | Simple           | —              |
| configuracion          | Simple           | —              |

## MODELO

| Atributo  | Tipo de atributo | Llave          |
| --------- | ---------------- | -------------- |
| id_modelo | Simple           | Llave primaria |
| nombre    | Simple           | —              |
| version   | Simple           | —              |
| algoritmo | Simple           | —              |

## METRICA

| Atributo      | Tipo de atributo | Llave          |
| ------------- | ---------------- | -------------- |
| id_metrica    | Simple           | Llave primaria |
| nombre        | Simple           | —              |
| valor         | Simple           | —              |
| fecha_calculo | Simple           | —              |

# DICCIONARIO DE DATOS SEMANA 2 ACTUALIZADO


## CIENTIFICO DE DATOS 
| Atributo      | Tipo de dato preliminar | PK | FK |
| ------------- | ----------------------- | -- | -- |
| id_cientifico | INT                     | Sí | No |
| nombre        | VARCHAR                 | No | No |
| correo        | VARCHAR                 | No | No |
| especialidad  | VARCHAR                 | No | No |

## PROYECTO
| Atributo         | Tipo de dato preliminar | PK | FK |
| ---------------- | ----------------------- | -- | -- |
| id_proyecto      | INT                     | Sí | No |
| nombre           | VARCHAR                 | No | No |
| problema_negocio | TEXT                    | No | No |
| descripcion      | TEXT                    | No | No |


## DATASET
| Atributo     | Tipo de dato preliminar | PK | FK |
| ------------ | ----------------------- | -- | -- |
| id_dataset   | INT                     | Sí | No |
| nombre       | VARCHAR                 | No | No |
| fuente       | VARCHAR                 | No | No |
| fecha_carga  | DATE                    | No | No |
| tamano_filas | INT                     | No | No |


## EXPERIMENTO
| Atributo               | Tipo de dato preliminar | PK | FK |
| ---------------------- | ----------------------- | -- | -- |
| id_experimento_interno | INT                     | Sí | No |
| nombre_experimento     | VARCHAR                 | No | No |
| fecha_ejecucion        | DATE                    | No | No |
| configuracion          | TEXT                    | No | No |

## MODELO 

| Atributo  | Tipo de dato preliminar | PK | FK |
| --------- | ----------------------- | -- | -- |
| id_modelo | INT                     | Sí | No |
| nombre    | VARCHAR                 | No | No |
| version   | VARCHAR                 | No | No |
| algoritmo | VARCHAR                 | No | No |

## METRICA 

| Atributo      | Tipo de dato preliminar | PK | FK |
| ------------- | ----------------------- | -- | -- |
| id_metrica    | INT                     | Sí | No |
| nombre        | VARCHAR                 | No | No |
| valor         | DECIMAL                 | No | No |
| fecha_calculo | DATE                    | No | No |
