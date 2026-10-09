# Semana 8 — Actividades y Ejercicios

## DML completo, filtros, operadores, orden y funciones de agregación

**Caso hilo conductor:** DataLab

---

# 1. Objetivo

Aplicar de manera práctica:

- `INSERT`
- `SELECT`
- `UPDATE`
- `DELETE`
- `WHERE`
- Operadores de comparación.
- `BETWEEN`
- `IN`
- `LIKE`
- `IS NULL`
- `IS NOT NULL`
- `AND`
- `OR`
- `NOT`
- `ORDER BY`
- `COUNT`
- `SUM`
- `AVG`
- `MIN`
- `MAX`
- `GROUP BY`
- `HAVING`

Además, resolver preguntas de negocio utilizando los datos de DataLab.

---

# 2. Entorno de trabajo

Trabajar sobre la base de datos `datalab` construida durante las semanas anteriores.

El archivo principal de consultas será:

```text
scripts/consultas/s08-filtros-orden-agregacion.sql
```

Las preguntas de negocio deben documentarse en:

```text
casos_uso/s06-preguntas-negocio.md
```

---

# BLOQUE 1 — Actividades conceptuales

## Actividad 1 — Los cuatro comandos DML

Completa la siguiente tabla:

| Comando | ¿Qué hace? | Tabla DataLab donde lo aplicarías |
|---|---|---|
| `INSERT` |Inserta nuevos registros en una tabla. |Proyecto |
| `SELECT` | Consulta y muestra informacion almacenada en la tabla |Dataset |
| `UPDATE` |Modifica los datos de registros existentes. |  experimento|
| `DELETE` |  Elimina registros de una tabla.| Poyecto |

### Pregunta Feynman

Explica con tus propias palabras la diferencia entre `UPDATE` y `ALTER TABLE`.

UPDATE se utiliza para modificar los valores de los registros que ya existen en una tabla. Por ejemplo, cambiar el estado de un experimento de pendiente a exitoso.

En cambio, ALTER TABLE se utiliza para modificar la estructura de una tabla, por ejemplo, agregar una columna, cambiar el tipo de dato o eliminar una columna.

En conclusión, UPDATE modifica los datos, mientras que ALTER TABLE modifica la estructura de la tabla.

---

# Actividad 2 — UPDATE y DELETE sin WHERE

Analiza:

```sql
UPDATE experimento
SET estado = 'fallido';
```

Responde:

1. ¿Es una instrucción válida?
Sí, es una instrucción SQL válida.
2. ¿Qué filas modifica?
Modifica todas las filas de la tabla experimento, estableciendo el valor de la columna estado como 'fallido'.
3. ¿Por qué puede ser peligrosa?
Porque, al no tener una cláusula WHERE, no distingue entre los experimentos. Todos quedan con el estado 'fallido', incluso aquellos que antes estaban exitosos o pendientes.
4. ¿Cómo comprobarías primero qué filas serán afectadas?
Ejecutando primero un SELECT para visualizar todos los registros:

Ahora analiza:

```sql
DELETE FROM experimento;
```

Explica qué diferencia existe entre eliminar las filas y eliminar la tabla.


La instrucción DELETE FROM experimento; elimina todos los registros de la tabla experimento, pero conserva la estructura de la tabla, sus columnas y sus restricciones.

En cambio, DROP TABLE experimento; elimina la tabla completa, incluyendo su estructura y los datos almacenados.

Por eso, DELETE sin WHERE puede causar pérdida de información, mientras que DROP TABLE elimina también la estructura de la tabla.

---

# Actividad 3 — Operadores

Completa con un ejemplo de DataLab:

| Operador | Ejemplo | ¿Qué busca? |
|---|---|---|
| `=` | SELECT * FROM experimento WHERE estado = 'exitoso';| Experimentos cuyo estado sea exitoso.|
| `<>` | SELECT * FROM experimento WHERE estado <> 'fallido';| Experimentos cuyo estado sea diferente de fallido.|
| `>` |SELECT * FROM metrica WHERE valor > 0.80; | Métricas con valor superior a 0.80. |
| `<` | SELECT * FROM metrica WHERE valor < 0.50;|Métricas con valor inferior a 0.50. |
| `>=` | SELECT * FROM metrica WHERE valor >= 0.80;| Métricas con valor mayor o igual a 0.80.|
| `<=` | SELECT * FROM metrica WHERE valor <= 0.50;| Métricas con valor menor o igual a 0.50.|
| `BETWEEN` |SELECT * FROM metrica WHERE valor BETWEEN 0.70 AND 0.90; | Métricas con valores entre 0.70 y 0.90, incluidos los extremos.|
| `IN` |SELECT * FROM experimento WHERE estado IN ('exitoso', 'fallido'); | Experimentos cuyo estado coincida con alguno de los valores indicados.|
| `LIKE` |SELECT * FROM dataset WHERE nombre LIKE 'EEG%'; | Datasets cuyos nombres comiencen por EEG. |
| `IS NULL` |SELECT * FROM dataset WHERE notas IS NULL; |Datasets que no tienen valor en el campo notas. |
| `IS NOT NULL` |SELECT * FROM dataset WHERE notas IS NOT NULL; | Datasets que sí tienen un valor en el campo notas. |

---

# Actividad 4 — NULL

Explica por qué esta consulta no es la forma correcta de buscar valores nulos:

```sql
SELECT *
FROM dataset
WHERE notas = NULL;
```

Escribe la consulta correcta.


La consulta WHERE notas = NULL no es correcta porque NULL representa un valor ausente o desconocido y no se puede comparar utilizando el operador de igualdad. Para buscar registros que no tengan información en el campo notas, se debe utilizar IS NULL. Si queremos buscar registros que sí tengan información, utilizamos IS NOT NULL.

---

# Actividad 5 — AND, OR y NOT

Construye consultas que permitan:

### a)
Obtener experimentos exitosos.

SELECT *
FROM experimento
WHERE estado = 'exitoso';

### b)
Obtener experimentos exitosos o fallidos.

SELECT *
FROM experimento
WHERE estado = 'exitoso'
   OR estado = 'fallido';

### c)
Obtener métricas cuyo valor esté entre 0.70 y 0.90.

SELECT *
FROM metrica
WHERE valor >= 0.70
  AND valor <= 0.90;

### d)
Obtener experimentos cuyo estado no sea `fallido`.

SELECT *
FROM experimento
WHERE NOT estado = 'fallido';

### e)
Crear una consulta que combine `AND` y `OR` utilizando paréntesis.

SELECT *
FROM experimento
WHERE (estado = 'exitoso' OR estado = 'fallido')
  AND id_proyecto = 1;

Explica por qué utilizaste los paréntesis.

Los paréntesis permiten agrupar las condiciones que deben evaluarse juntas. En este caso, primero se consideran los experimentos exitosos o fallidos y después se filtran aquellos que pertenecen al proyecto con identificador 1. Esto permite controlar la lógica de la consulta y evitar resultados no deseados.

---

# BLOQUE 2 — Laboratorio de filtros

## Actividad 6 — Filtros básicos

Crea una consulta para cada caso:

1. Buscar un proyecto por su nombre.

SELECT *
FROM proyecto
WHERE nombre = 'Detección de fraude en transacciones';
2. Buscar métricas mayores a `0.80`.

SELECT *
FROM metrica
WHERE valor > 0.80;
3. Buscar métricas menores o iguales a `0.50`.

SELECT *
FROM metrica
WHERE valor <= 0.50;
4. Buscar métricas entre `0.70` y `0.90`.

SELECT *
FROM metrica
WHERE valor BETWEEN 0.70 AND 0.90;
5. Buscar experimentos cuyo estado esté dentro de una lista de estados.

SELECT *
FROM experimento
WHERE estado IN ('exitoso', 'fallido');
6. Buscar datasets cuyo nombre comience por una palabra determinada.

SELECT *
FROM dataset
WHERE nombre LIKE 'EEG%';
7. Buscar datasets sin notas.

SELECT *
FROM dataset
WHERE notas IS NULL;
8. Buscar datasets que sí tengan notas.

SELECT *
FROM dataset
WHERE notas IS NOT NULL;

Guarda todas las consultas en:

```text
scripts/consultas/s08-filtros-orden-agregacion.sql
```

---

# Actividad 7 — Comparación de operadores

Para una misma tabla, crea tres consultas:

```text
Consulta A → utilizando OR
Consulta B → utilizando IN
Consulta C → utilizando NOT IN
```

Explica cuándo sería más conveniente cada una.

---

# Actividad 8 — LIKE

Utilizando `dataset.nombre`, crea consultas para:

1. Nombres que comiencen por `EEG`.
2. Nombres que terminen en una palabra que elijas.
3. Nombres que contengan una palabra determinada.
4. Nombres con un patrón de longitud utilizando `_`.

Documenta el resultado obtenido.

---

# BLOQUE 3 — Ordenamiento

## Actividad 9 — ORDER BY

Crea las siguientes consultas:

### a)
Datasets ordenados por nombre ascendente.

### b)
Datasets ordenados por fecha de carga descendente.

### c)
Datasets ordenados por fuente y, en caso de empate, por fecha de carga descendente.

```sql
ORDER BY fuente ASC, fecha_carga DESC;
```

### Pregunta

Si dos datasets tienen la misma fuente, ¿qué criterio decide cuál aparece primero?

---

# BLOQUE 4 — Funciones de agregación

## Actividad 10 — COUNT

Responde mediante SQL:

1. ¿Cuántos datasets existen?
2. ¿Cuántos experimentos existen?
3. ¿Cuántos modelos existen?
4. ¿Cuántas métricas existen?

---

# Actividad 11 — AVG, MIN y MAX

Para la tabla `metrica`, calcula:

- Promedio.
- Valor mínimo.
- Valor máximo.

Después calcula esos tres valores agrupados por `nombre_metrica`.

---

# Actividad 12 — GROUP BY

Resuelve:

### a)
¿Cuántos datasets existen por fuente?

```sql
SELECT fuente, COUNT(*) AS cantidad
FROM dataset
GROUP BY fuente;
```

### b)
¿Cuántos experimentos existen por estado?

```sql
SELECT estado, COUNT(*) AS cantidad
FROM experimento
GROUP BY estado;
```

### c)
¿Cuántas métricas existen por tipo de métrica?

```sql
SELECT nombre_metrica, COUNT(*) AS cantidad
FROM metrica
GROUP BY nombre_metrica;
```

---

# Actividad 13 — HAVING

Construye una consulta que muestre únicamente los tipos de métrica cuyo promedio sea superior a `0.8`.

La solución debe utilizar:

```text
GROUP BY
HAVING
AVG()
```

No utilices:

```sql
WHERE AVG(valor) > 0.8
```

Explica por qué.

---

# BLOQUE 5 — UPDATE seguro

## Actividad 14 — SELECT primero

Selecciona un registro de DataLab que puedas modificar de forma controlada.

### Paso 1

Escribe el `SELECT` que identifica el registro.

```sql
SELECT *
FROM ...
WHERE ...;
```

### Paso 2

Realiza una modificación mediante `UPDATE`.

### Paso 3

Ejecuta nuevamente el `SELECT`.

### Evidencia

Documenta:

- Valor inicial.
- Valor modificado.
- Condición utilizada en `WHERE`.
- Resultado después del `UPDATE`.

---

# BLOQUE 6 — DELETE seguro

## Actividad 15 — Registro de prueba

Inserta un registro temporal claramente identificable.

Ejemplo:

```sql
INSERT INTO proyecto (nombre, descripcion)
VALUES (
    'FILA_DE_PRUEBA_BORRAR',
    'Registro creado para practicar DELETE'
);
```

Comprueba su existencia:

```sql
SELECT *
FROM proyecto
WHERE nombre = 'FILA_DE_PRUEBA_BORRAR';
```

Elimínalo:

```sql
DELETE FROM proyecto
WHERE nombre = 'FILA_DE_PRUEBA_BORRAR';
```

Comprueba nuevamente:

```sql
SELECT *
FROM proyecto
WHERE nombre = 'FILA_DE_PRUEBA_BORRAR';
```

### Pregunta

¿Por qué es importante que el registro de prueba sea claramente identificable?

---

# BLOQUE 7 — Preguntas de negocio

## Actividad 16 — Retomar las preguntas de la Semana 6

Revisen:

```text
casos_uso/s06-preguntas-negocio.md
```

Identifiquen una pregunta que anteriormente no podían resolver fácilmente y que ahora pueda responderse utilizando filtros u operaciones de agregación.

Actualicen el archivo con:

```text
Pregunta:
________________________________________

Objetivo:
________________________________________

Consulta SQL:
________________________________________

Resultado:
________________________________________

Interpretación:
________________________________________
```

---

# Actividad 17 — Nuevas preguntas de negocio

Resuelve las siguientes preguntas utilizando SQL.

## Pregunta de negocio 1

**¿Cuántos datasets existen por fuente?**

Requisito:

```text
GROUP BY + COUNT
```

---

## Pregunta de negocio 2

**¿Cuántos experimentos se encuentran en cada estado?**

Requisito:

```text
GROUP BY estado + COUNT
```

---

## Pregunta de negocio 3

**¿Cuál es el promedio de cada tipo de métrica?**

Requisito:

```text
GROUP BY + AVG
```

---

## Pregunta de negocio 4

**¿Qué tipos de métrica tienen un promedio superior a 0.8?**

Requisito:

```text
GROUP BY + AVG + HAVING
```

---

## Pregunta de negocio 5

**¿Cuál es el dataset más reciente de cada fuente?**

Resolver primero con los conceptos disponibles esta semana.

Pista:

```text
filtro + ordenamiento
```

Si consideran que la solución completa requiere conceptos todavía no estudiados, documenten la limitación y propongan una aproximación.

---

## Pregunta de negocio 6

**¿Qué experimentos tienen estados considerados como exitosos o fallidos?**

Requisito:

```text
IN
```

---

## Pregunta de negocio 7

**¿Qué datasets tienen información en el campo `notas`?**

Requisito:

```text
IS NOT NULL
```

---

## Pregunta de negocio 8

**¿Qué métricas tienen valores entre 0.70 y 0.90?**

Requisito:

```text
BETWEEN
```

---

## Actividad 18 — Crear una pregunta de negocio propia

Cada equipo debe proponer una pregunta relacionada con DataLab que pueda resolverse utilizando únicamente los conceptos estudiados hasta esta semana.

La pregunta debe:

1. Tener un contexto de negocio.
2. Ser verificable con datos.
3. Utilizar SQL.
4. Tener una respuesta interpretable.

Formato:

```text
Pregunta de negocio:
________________________________________

¿Por qué es importante?
________________________________________

Tablas utilizadas:
________________________________________

Consulta SQL:
________________________________________

Resultado:
________________________________________

Interpretación:
________________________________________
```

---

# BLOQUE 8 — Desafío Feynman

## Actividad 19 — Explícalo sin SQL

Explica a un compañero:

### ¿Qué diferencia existe entre WHERE y HAVING?

La explicación debe ser suficientemente clara para que la otra persona pueda comprenderla sin mirar una consulta SQL.

---

## Actividad 20 — Explícalo con un ejemplo

Explica por qué:

```sql
WHERE notas = NULL
```

no debe utilizarse para buscar valores nulos.

Después explica la solución:

```sql
WHERE notas IS NULL
```

---

# BLOQUE 9 — Comparación SQL Server / MySQL

## Actividad 21

Ejecuta una consulta equivalente en SQL Server y MySQL.

Identifica:

- Qué parte de la consulta es idéntica.
- Qué parte cambia.
- Por qué cambia.

Utiliza como referencia la limitación de resultados:

### SQL Server

```sql
SELECT TOP 5 *
FROM dataset
ORDER BY fecha_carga DESC;
```

### MySQL

```sql
SELECT *
FROM dataset
ORDER BY fecha_carga DESC
LIMIT 5;
```

---

# BLOQUE 10 — Entregable

El archivo principal debe quedar en:

```text
scripts/consultas/s08-filtros-orden-agregacion.sql
```

Debe contener:

- Consultas con operadores de comparación.
- `BETWEEN`.
- `IN`.
- `LIKE`.
- `IS NULL`.
- `IS NOT NULL`.
- `AND` / `OR` / `NOT`.
- `ORDER BY` con múltiples criterios.
- `COUNT`.
- `SUM`, cuando sea aplicable.
- `AVG`.
- `MIN`.
- `MAX`.
- `GROUP BY`.
- `HAVING`.
- Al menos un `UPDATE` seguro.
- Al menos un `DELETE` seguro.
- Consultas correspondientes a preguntas de negocio.

Actualizar también:

```text
casos_uso/s06-preguntas-negocio.md
```

---

# BLOQUE 11 — Git

Al finalizar:

```bash
git add scripts/consultas/s08-filtros-orden-agregacion.sql
git add casos_uso/s06-preguntas-negocio.md
```

Commit:

```bash
git commit -m "consulta: filtros, orden y funciones de agregación sobre DataLab"
```

---

# BLOQUE 12 — Checklist

- [ ] Practiqué los cuatro comandos DML.
- [ ] Comprendí el riesgo de `UPDATE` sin `WHERE`.
- [ ] Comprendí el riesgo de `DELETE` sin `WHERE`.
- [ ] Utilicé `=`, `<>`, `<`, `>`, `<=`, `>=`.
- [ ] Utilicé `BETWEEN`.
- [ ] Utilicé `IN`.
- [ ] Utilicé `LIKE`.
- [ ] Utilicé `IS NULL` e `IS NOT NULL`.
- [ ] Combiné condiciones con `AND`, `OR` y `NOT`.
- [ ] Utilicé paréntesis en condiciones complejas.
- [ ] Utilicé `ORDER BY` con múltiples criterios.
- [ ] Utilicé funciones de agregación.
- [ ] Utilicé `GROUP BY`.
- [ ] Utilicé `HAVING`.
- [ ] Apliqué la disciplina de `SELECT` primero.
- [ ] Realicé al menos un `UPDATE` controlado.
- [ ] Realicé al menos un `DELETE` controlado.
- [ ] Resolví preguntas de negocio.
- [ ] Actualicé `casos_uso/s06-preguntas-negocio.md`.
- [ ] Guardé las consultas en `scripts/consultas/s08-filtros-orden-agregacion.sql`.
- [ ] Realicé el commit de la semana.
