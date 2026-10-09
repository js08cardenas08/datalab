# Semana 7 — Guía de Actividad
## Evolución del esquema de DataLab con ALTER TABLE, restricciones y DROP

**Caso integrador:** DataLab  
**SGBD:** SQL Server  
**Herramienta:** SQL Server Management Studio (SSMS)  
**Modalidad:** Formalización + laboratorio  
**Repositorio:** GitHub del equipo

---

# 1. Propósito

Durante las semanas anteriores construyeron la base de datos DataLab.

Ahora el sistema ya tiene:

- tablas;
- relaciones;
- restricciones;
- datos semilla;
- información real de prueba.

Pero los sistemas reales evolucionan.

El equipo de DataLab recibe dos nuevas necesidades:

1. conocer el **estado** de cada experimento;
2. registrar **observaciones libres** sobre cada dataset.

Los documentos de Semana 7 plantean estos dos cambios como el escenario central para aprender a evolucionar un esquema existente. fileciteturn14file0L32-L34

---

# 2. Objetivos

Al finalizar la actividad podrás:

- modificar tablas existentes con `ALTER TABLE`;
- agregar columnas;
- modificar columnas;
- renombrar columnas;
- eliminar columnas de una tabla de prueba;
- agregar restricciones;
- identificar problemas causados por datos existentes;
- utilizar `UPDATE` para preparar datos antes de aplicar restricciones;
- comprender el riesgo de `DROP TABLE` y `DROP DATABASE`;
- documentar una evolución del esquema;
- versionar el cambio mediante Git.

Estos objetivos corresponden a los resultados establecidos para la Semana 7. fileciteturn14file1L8-L15

---

# 3. Regla fundamental de la actividad

Durante esta actividad trabajaremos sobre la base existente.

Por eso:

> **No vamos a borrar y reconstruir las ocho tablas de DataLab para resolver los cambios.**

Vamos a evolucionarlas.

La idea es:

```text
Modelo existente
      ↓
Datos existentes
      ↓
Nueva necesidad
      ↓
ALTER TABLE
      ↓
Nueva versión del esquema
```

---

# 4. Preparar el entorno

## Paso 1 — Abrir SSMS

Conéctate a SQL Server mediante SQL Server Management Studio.

## Paso 2 — Seleccionar DataLab

Trabaja sobre:

```text
datalab
```

## Paso 3 — Verificar las tablas

Comprueba que existen:

```text
cientifico_datos
proyecto
dataset
experimento
modelo
metrica
participacion
uso_dataset
```

## Paso 4 — Verificar que existen datos

Ejecuta:

```sql
SELECT * FROM experimento;
```

y:

```sql
SELECT * FROM dataset;
```

La actividad depende de que existan datos reales, porque el objetivo es aprender a modificar un esquema que ya está en uso. fileciteturn14file0L17-L20

---

# 5. BLOQUE 1 — Formalización sin PC

## Paso 1 — Analizar el escenario

DataLab solicita:

```text
Cambio 1
Agregar estado a experimento

Cambio 2
Agregar notas a dataset
```

Escribe:

```text
¿Por qué no sería apropiado volver a ejecutar
CREATE TABLE para resolver estos cambios?

Respuesta:

Porque las tablas de DataLab ya existen y tienen información guardada. Si las volvemos a crear, podemos generar errores o perder información. Para agregar nuevas columnas o cambiar la estructura de las tablas que ya existen, utilizamos ALTER TABLE.
```

---

# 6. Paso 2 — Diseñar el cambio `estado`

La tabla:

```text
experimento
```

debe incorporar:

```text
estado
```

Los estados permitidos serán:

```text
planificado
en_ejecucion
exitoso
fallido
```

Antes de escribir SQL, define:

```text
Nombre:
estado

Tipo:
VARCHAR(20)

¿Puede ser NULL?
No

DEFAULT:
planificado

CHECK:
planificado
en_ejecucion
exitoso
fallido
```

---

# 7. Paso 3 — Predecir el problema

Antes de ejecutar:

```sql
ALTER TABLE experimento
ADD estado VARCHAR(20) NOT NULL;
```

responde:

```text
¿Qué ocurrirá si experimento ya tiene registros?

SQL Server puede rechazar la operación porque los registros que ya existen necesitan un valor para la nueva columna y no pueden recibir NULL. Para solucionarlo, podemos definir un DEFAULT que asigne un valor válido a esos registros.
```

La idea que debes identificar es:

```text
Filas existentes
      +
Nueva columna NOT NULL
      =
¿qué valor recibirán las filas?
```

---

# 8. Paso 4 — Diseñar la solución

Propón una solución utilizando:

```text
DEFAULT
```

Escribe primero el comando en papel.

```sql
ALTER TABLE experimento
ADD estado VARCHAR(20) NOT NULL
    CONSTRAINT df_experimento_estado
    DEFAULT 'planificado'
    WITH VALUES;;
```

Después explica:

```text
¿Qué valor recibirán los registros existentes?

Utilizando DEFAULT 'planificado' al agregar la columna. Los registros existentes recibirán el valor 'planificado' mediante WITH VALUES.
```

---

# 9. Paso 5 — Diseñar el CHECK

Escribe la restricción que permita únicamente:

```text
planificado
en_ejecucion
exitoso
fallido
```

```sql
ALTER TABLE dbo.experimento
ADD CONSTRAINT chk_experimento_estado
CHECK (
    estado IN (
        'planificado',
        'en_ejecucion',
        'exitoso',
        'fallido'
    )
);
```

---

# 10. Paso 6 — Cambio en dataset

Ahora DataLab solicita una nueva columna:

```text
notas
```

Propón:

```text
Nombre:
notas

Tipo:
VARCHAR(MAX).

¿Puede ser NULL?
Sí, porque un dataset puede no tener observaciones registradas.
```

Escribe el `ALTER TABLE`:

```sql
ALTER TABLE dbo.dataset
ADD notas VARCHAR(MAX) NULL;
```

---

# 11. Paso 7 — Relación con UPDATE

El documento de la Semana 7 propone actualizar algunos experimentos después de agregar `estado`. fileciteturn14file0L98-L107

Escribe:

```sql
UPDATE experimento
SET estado = 'exitoso'
WHERE id_experimento = 1;
```

Antes de ejecutarlo, explica:

```text
¿Por qué se utiliza WHERE?

Porque WHERE permite indicar qué registro queremos modificar. En este caso, actualizamos el estado del experimento cuyo identificador es 1, sin cambiar el estado de todos los experimentos.
```

---

# 12. Paso 8 — Relación con Git

Explica:

```text
¿Por qué este cambio puede considerarse
una migración de esquema?

Porque estamos modificando la estructura de una base de datos que ya existe para adaptarla a nuevas necesidades. Los cambios se guardan en un script y se registran en Git, lo que permite identificar cómo ha evolucionado la base de datos.
```

La idea central es que el script de modificación representa una evolución incremental y trazable del diseño. fileciteturn14file0L76-L80

---

# 13. BLOQUE 2 — Laboratorio con PC

## Paso 1 — Verificar nuevamente los datos

Ejecuta:

```sql
SELECT *
FROM experimento;
```

Después:

```sql
SELECT *
FROM dataset;
```

Guarda mentalmente o documenta el estado inicial.

---

# 14. Paso 2 — Agregar `estado`

Ejecuta la solución diseñada.

Una implementación posible en SQL Server es:

```sql
ALTER TABLE experimento
ADD estado VARCHAR(20) NOT NULL
    CONSTRAINT df_experimento_estado
    DEFAULT 'planificado'
    WITH VALUES;
```

Después verifica:

```sql
SELECT
    id_experimento,
    estado
FROM experimento;
```

---

# 15. Paso 3 — Agregar `CHECK`

Ejecuta:

```sql
ALTER TABLE experimento
ADD CONSTRAINT chk_experimento_estado
CHECK (
    estado IN (
        'planificado',
        'en_ejecucion',
        'exitoso',
        'fallido'
    )
);
```

Verifica los datos:

```sql
SELECT
    id_experimento,
    estado
FROM experimento;
```

---

# 16. Paso 4 — Probar el CHECK

Intenta:

```sql
UPDATE experimento
SET estado = 'terminado'
WHERE id_experimento = 1;
```

Observa el resultado.

Documenta:

```text
¿Qué ocurrió?

SQL Server rechazó la actualización porque se intentó asignar el estado terminado al experimento con identificador 1. La operación no se realizó porque ese valor no está permitido por la restricción CHECK.

¿Por qué SQL Server rechazó o aceptó la operación?

SQL Server rechazó la operación porque la restricción chk_experimento_estado solo permite los estados planificado, en_ejecucion, exitoso y fallido. Como terminado no está dentro de esos valores, la base de datos impide guardar ese cambio y mantiene el estado anterior del experimento.
```

La prueba permite comprobar que la restricción realmente está funcionando.

---

# 17. Paso 5 — Actualizar un estado válido

Ahora utiliza un valor permitido:

```sql
UPDATE experimento
SET estado = 'exitoso'
WHERE id_experimento = 1;
```

Verifica:

```sql
SELECT
    id_experimento,
    estado
FROM experimento
WHERE id_experimento = 1;
```

---

# 18. Paso 6 — Agregar `notas`

Ejecuta:

```sql
ALTER TABLE dataset
ADD notas VARCHAR(MAX) NULL;
```

Verifica:

```sql
SELECT
    id_dataset,
    nombre,
    notas
FROM dataset;
```

---

# 19. Paso 7 — Agregar una restricción adicional

Revisa el modelo.

Identifica una regla que pueda faltar.

Por ejemplo:

```text
UNIQUE
```

Si corresponde a tu modelo, agrega una restricción:

```sql
ALTER TABLE proyecto
ADD CONSTRAINT uq_proyecto_nombre
UNIQUE (nombre);
```

> Antes de ejecutar la restricción, verifica que no existan duplicados en los datos actuales.

Documenta:

```text
Restricción agregada:

Se agrega una restricción UNIQUE a la columna nombre de la tabla proyecto, con el nombre uq_proyecto_nombre.

¿Por qué es necesaria?

La restricción es necesaria para evitar que se registren dos proyectos con el mismo nombre. De esta manera, se mantiene la información más organizada y se evitan confusiones al consultar los proyectos de DataLab.
Ojo, bro: esta restricción solo debe agregarse si en el modelo de DataLab el nombre de cada proyecto debe ser único. Si pueden existir proyectos diferentes con el mismo nombre, no sería correcto imponerla.
```

---

# 20. Paso 8 — Practicar modificación de columna

Identifica una columna `VARCHAR` cuyo tamaño pueda ampliarse de manera justificada.

En SQL Server:

```sql
ALTER TABLE tabla
ALTER COLUMN columna VARCHAR(200);
```

Antes de ejecutar:

```text
¿Qué tamaño tenía?

La columna descripcion tenía un tamaño de 50 caracteres.

¿Qué tamaño tendrá?

Después de ejecutar ALTER COLUMN, tendrá un tamaño máximo de 200 caracteres.

¿Por qué se amplía?

Se amplía para permitir almacenar textos más largos sin tener que crear otra columna. De esta manera, se puede adaptar la estructura de la base de datos a nuevas necesidades.
```

---

# 21. Paso 9 — Renombrar una columna

Los documentos fuente presentan `CHANGE COLUMN`, que corresponde a MySQL.

Para esta práctica en SQL Server se puede utilizar:

```sql
EXEC sp_rename
    'tabla.columna_actual',
    'columna_nueva',
    'COLUMN';
```

No renombres una columna real de DataLab sin justificarlo y verificar las dependencias.

El objetivo principal es comprender la operación y reconocer la diferencia entre dialectos.

---

# 22. Paso 10 — Practicar DROP de forma segura

**No ejecutar `DROP` sobre las ocho tablas reales de DataLab.**

Crea una tabla desechable:

```sql
CREATE TABLE tabla_prueba_drop (
    id INT PRIMARY KEY,
    dato VARCHAR(50)
);
```

Inserta un registro:

```sql
INSERT INTO tabla_prueba_drop
VALUES (1, 'prueba');
```

Consulta:

```sql
SELECT *
FROM tabla_prueba_drop;
```

---

# 23. Paso 11 — DROP COLUMN

Ahora elimina únicamente la columna de prueba:

```sql
ALTER TABLE tabla_prueba_drop
DROP COLUMN dato;
```

Verifica la estructura.

El objetivo es observar la diferencia entre:

```text
eliminar una columna
```

y:

```text
eliminar una tabla
```

---

# 24. Paso 12 — DROP TABLE

Cuando hayas terminado:

```sql
DROP TABLE tabla_prueba_drop;
```

Después intenta consultar:

```sql
SELECT *
FROM tabla_prueba_drop;
```

Observa el resultado.

Esto permite experimentar con `DROP` sin poner en riesgo las tablas reales.

La guía docente establece expresamente que esta es la tabla desechable para practicar `DROP`. fileciteturn14file0L120-L136

---

# 25. Reto — Detectar un problema antes de agregar una restricción

Supón que queremos agregar:

```text
UNIQUE(nombre)
```

Primero consulta:

```sql
SELECT
    nombre,
    COUNT(*) AS cantidad
FROM proyecto
GROUP BY nombre
HAVING COUNT(*) > 1;
```

Analiza:

```text
¿Existen duplicados?

Se debe revisar el resultado de la consulta. Si aparecen registros, existen nombres repetidos. Si no aparecen registros, la consulta no encontró duplicados.

¿Se puede agregar UNIQUE inmediatamente?

Solo si los datos cumplen la regla de unicidad y el modelo del proyecto establece que no puede haber dos proyectos con el mismo nombre.

¿Qué habría que hacer primero?

Consultar los registros duplicados, revisar por qué se repiten y corregirlos si corresponde. Después se puede agregar la restricción, siempre que esa regla sea válida para DataLab.
```

---

# 26. Reto — CHECK sobre datos existentes

Imagina que existe:

```text
estado = 'terminado'
```

y la nueva regla solo permite:

```text
planificado
en_ejecucion
exitoso
fallido
```

El procedimiento correcto sería:

```text
1. Detectar datos inválidos
        ↓
2. Corregirlos con UPDATE
        ↓
3. Agregar CHECK
        ↓
4. Verificar
```

Documenta un ejemplo.

```sql
UPDATE experimento
SET estado = 'exitoso'
WHERE id_experimento = 1;

```

---

# 27. Reto — Diferenciar DML y DDL

Clasifica:

```text
INSERT
UPDATE
DELETE
SELECT
ALTER TABLE
DROP TABLE
CREATE TABLE
```

Completa:

```text
DML:
INSERT, UPDATE, DELETE y SELECT.

DDL:
ALTER TABLE, DROP TABLE y CREATE TABLE.
```

Explica la diferencia con tus propias palabras.

DML se utiliza para consultar y manipular los datos que están almacenados en las tablas. DDL se utiliza para crear, modificar o eliminar estructuras de la base de datos, como tablas y columnas.

---

# 28. Documentación

Actualiza:

```text
documentacion/diccionario_datos.md
```

Incluye:

```text
experimento
└── estado

dataset
└── notas
```

También documenta las restricciones nuevas.


```
Evolución del esquema — Semana 7

Tabla: experimento

Columna nueva: estado

Tipo de dato: VARCHAR(20)

Permite valores nulos: No.

Valor por defecto: planificado.

Restricción: CHECK para permitir únicamente planificado, en_ejecucion, exitoso y fallido.

La columna permite identificar el estado actual de cada experimento.

Tabla: dataset

Columna nueva: notas

Tipo de dato: VARCHAR(MAX)

Permite valores nulos: Sí.

La columna permite guardar observaciones adicionales relacionadas con cada dataset.

Restricciones

Se agregó una restricción DEFAULT para asignar el estado inicial de los experimentos y una restricción CHECK para controlar los valores permitidos.

La restricción UNIQUE sobre el nombre del proyecto solo se documentará como implementada si se verificó que corresponde al modelo y se agregó correctamente.
```

---

# 29. Registrar decisiones

Actualiza:

```text
documentacion/decisiones.md
```

Incluye:

```text
Semana 7 — Evolución del esquema de DataLab

Fecha: [09/10/2026].

Cambio realizado: Se agregó la columna estado a la tabla experimento y la columna notas a la tabla dataset.

Motivo: Permitir el seguimiento del estado de los experimentos y registrar observaciones adicionales sobre los datasets.

Problema encontrado: Las restricciones de integridad pueden rechazar operaciones cuando los valores ingresados no cumplen las reglas definidas.

Solución: Se revisaron los valores permitidos, se realizaron pruebas con estados válidos e inválidos y se verificaron los resultados mediante consultas SQL.

Restricciones afectadas: DEFAULT y CHECK para el estado de los experimentos. La restricción UNIQUE se documentará si se implementó y se verificó correctamente.

Impacto sobre datos existentes: La columna estado se configura con el valor predeterminado planificado para los registros existentes al agregarla con WITH VALUES. La columna notas permite valores nulos, por lo que no requiere completar inmediatamente todas las observaciones.

Pruebas realizadas: Se verificaron las columnas agregadas, los estados de los experimentos y el funcionamiento de las restricciones. También se practicaron modificaciones y eliminaciones sobre tablas desechables.
```

La guía docente solicita registrar específicamente qué ocurrió al aplicar restricciones sobre datos existentes y qué ajustes fueron necesarios. fileciteturn14file0L138-L145

---

# 30. Organizar los scripts

El repositorio debería contener:

```text
scripts/
├── ddl/
│   └── s05-creacion-tablas.sql
│
├── dml/
│   ├── s06-reset-datos.sql
│   └── s06-datos-semilla.sql
│
└── ddl/
    └── s07-evolucion-esquema.sql
```

Para evitar duplicar el nombre `ddl/`, la estructura recomendada final es:

```text
scripts/
├── ddl/
│   ├── s05-creacion-tablas.sql
│   └── s07-evolucion-esquema.sql
│
└── dml/
    ├── s06-reset-datos.sql
    └── s06-datos-semilla.sql
```

---

# 31. Estructura sugerida del script

```sql
/*
    DataLab
    Semana 7
    Evolución del esquema

    ALTER TABLE
    Restricciones
    UPDATE
    DROP de prueba
*/

USE datalab;
GO

-- ==========================================
-- 1. AGREGAR ESTADO
-- ==========================================

ALTER TABLE experimento
ADD estado VARCHAR(20) NOT NULL
    CONSTRAINT df_experimento_estado
    DEFAULT 'planificado'
    WITH VALUES;
GO


-- ==========================================
-- 2. AGREGAR CHECK
-- ==========================================

ALTER TABLE experimento
ADD CONSTRAINT chk_experimento_estado
CHECK (
    estado IN (
        'planificado',
        'en_ejecucion',
        'exitoso',
        'fallido'
    )
);
GO


-- ==========================================
-- 3. AGREGAR NOTAS
-- ==========================================

ALTER TABLE dataset
ADD notas VARCHAR(MAX) NULL;
GO


-- ==========================================
-- 4. ACTUALIZAR ESTADOS
-- ==========================================

-- Consultar primero el registro que se va a modificar.
SELECT id_experimento, estado
FROM experimento
WHERE id_experimento = 1;
GO

-- Ejecutar solo si el experimento con ID 1 existe
-- y corresponde actualizarlo a exitoso.
UPDATE experimento
SET estado = 'exitoso'
WHERE id_experimento = 1;
GO

-- Verificar el resultado.
SELECT id_experimento, estado
FROM experimento
WHERE id_experimento = 1;
GO


-- ==========================================
-- 5. RESTRICCIÓN ADICIONAL
-- ==========================================

-- Consultar si hay nombres de proyectos duplicados.
SELECT nombre, COUNT(*) AS cantidad
FROM proyecto
GROUP BY nombre
HAVING COUNT(*) > 1;
GO



-- ==========================================
-- 6. MODIFICACIÓN DE COLUMNA
-- ==========================================




-- ==========================================
-- 7. PRUEBA DROP
-- ==========================================

-- Crear una tabla exclusivamente para practicar.
CREATE TABLE tabla_prueba_drop (
    id INT PRIMARY KEY,
    dato VARCHAR(50)
);
GO

INSERT INTO tabla_prueba_drop (id, dato)
VALUES (1, 'prueba');
GO

SELECT *
FROM tabla_prueba_drop;
GO

-- Eliminar únicamente la columna de prueba.
ALTER TABLE tabla_prueba_drop
DROP COLUMN dato;
GO

SELECT *
FROM tabla_prueba_drop;
GO

-- Eliminar la tabla desechable.
DROP TABLE tabla_prueba_drop;
GO
```

---

# 32. Git

Después de validar:

```bash
git status
```

Agregar cambios:

```bash
git add .
```

Crear commit:

```bash
git commit -m "ddl: evolucion del esquema de DataLab (estado en experimento, notas en dataset)"
```

Enviar:

```bash
git push
```

El mensaje de commit corresponde al propuesto en los documentos de la Semana 7. fileciteturn14file0L143-L145

---

# 33. Evidencias de la actividad

El equipo debe poder demostrar:

- estado inicial de las tablas;
- columna `estado` agregada;
- `DEFAULT` aplicado;
- `CHECK` funcionando;
- columna `notas` agregada;
- modificación realizada con `UPDATE`;
- restricción adicional practicada;
- `DROP` realizado únicamente sobre tabla de prueba;
- diccionario actualizado;
- decisiones documentadas;
- commit realizado.

---

# 34. Reto Feynman

Explica a un compañero, sin leer el código:

### Reto 1

¿Por qué utilizamos `ALTER TABLE` y no `CREATE TABLE` nuevamente?

Porque la tabla ya existe y necesitamos modificar su estructura sin volver a crearla desde cero.

### Reto 2

¿Por qué agregar `NOT NULL` sobre una tabla que ya tiene datos puede generar un problema?

Porque los registros existentes necesitan tener un valor para esa columna. Si no se proporciona un valor válido, SQL Server puede rechazar la modificación.

### Reto 3

¿Por qué necesitamos `DEFAULT`?

Porque permite asignar automáticamente un valor cuando no se especifica uno al insertar un registro. En DataLab se utiliza planificado como estado inicial.

### Reto 4

¿Qué problema puede aparecer al agregar un `CHECK` sobre datos existentes?

Que algunos registros contengan valores que no cumplen la condición. En ese caso, es necesario revisar y corregir los datos antes de agregar la restricción.

### Reto 5

¿Cuál es la diferencia entre:

```text
DELETE
DROP COLUMN
DROP TABLE
DROP DATABASE
```

DELETE: elimina registros de una tabla.



DROP COLUMN: elimina una columna de una tabla.



DROP TABLE: elimina una tabla completa.



DROP DATABASE: elimina una base de datos completa.

### Reto 6

¿Por qué `ALTER TABLE` puede considerarse una migración de esquema?

Porque modifica de forma controlada la estructura de una base de datos existente para adaptarla a nuevos requisitos.

### Reto 7

¿Por qué debemos probar `DROP` únicamente sobre una tabla desechable?

Porque estas instrucciones pueden eliminar estructuras y datos de manera permanente. Una tabla de prueba permite aprender sin poner en riesgo la información real.

---

# 35. Checklist de entrega

## Base de datos

- [ ] `estado` agregado a `experimento`.
- [ ] `DEFAULT` configurado.
- [ ] `CHECK` configurado.
- [ ] `notas` agregada a `dataset`.
- [ ] Al menos una restricción adicional practicada.
- [ ] Al menos una modificación de columna practicada.
- [ ] `UPDATE` ejecutado y verificado.
- [ ] `DROP COLUMN` practicado en tabla de prueba.
- [ ] `DROP TABLE` practicado en tabla de prueba.
- [ ] Ninguna tabla real de DataLab fue eliminada.

## Documentación

- [ ] `documentacion/diccionario_datos.md` actualizado.
- [ ] `documentacion/decisiones.md` actualizado.
- [ ] Cambios explicados.
- [ ] Errores encontrados documentados.

## Git

- [ ] Script versionado.
- [ ] Commit realizado.
- [ ] Push realizado.
- [ ] Historial permite identificar la evolución.

---

# 36. Criterio de éxito

La actividad no se considera completa simplemente porque los comandos se ejecuten sin errores.

El equipo debe demostrar que comprende:

```text
Necesidad de negocio
        ↓
Cambio de esquema
        ↓
Análisis de datos existentes
        ↓
ALTER TABLE
        ↓
Restricciones
        ↓
UPDATE si es necesario
        ↓
Pruebas
        ↓
Documentación
        ↓
Git
```

La guía del estudiante establece como cierre la existencia de `estado`, `notas`, una restricción adicional, práctica controlada de `DROP`, documentación y commit. fileciteturn14file1L171-L178

---

# 37. Cierre

DataLab ya no es una base de datos estática.

Ahora empieza a comportarse como un sistema real:

```text
              DATA LAB
                  │
                  ▼
          ┌───────────────┐
          │    ESQUEMA    │
          └───────┬───────┘
                  │
             necesidad
                  │
                  ▼
            ALTER TABLE
                  │
        ┌─────────┼─────────┐
        ▼         ▼         ▼
      ADD      ALTER      DROP
        │         │         │
        └─────────┼─────────┘
                  ▼
             CONSTRAINTS
                  │
                  ▼
             VALIDACIÓN
                  │
                  ▼
              DOCUMENTACIÓN
                  │
                  ▼
                 GIT
```

> **El objetivo no es solamente aprender comandos. El objetivo es aprender a evolucionar una base de datos existente de forma controlada, verificable y trazable.**
