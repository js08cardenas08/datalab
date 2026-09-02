# Diccionario de datos


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
