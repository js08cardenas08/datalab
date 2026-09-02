# Semana 2 — Guía del Estudiante

## Modelo Relacional y Conversión del Modelo E-R (3.1–3.2)
### Caso hilo conductor: DataLab

---

## Objetivos de la semana

Al final de esta semana estarán en capacidad de:

- Definir el modelo relacional (tabla, tupla, atributo, dominio, grado) y distinguirlo con precisión del modelo E-R.
- Aplicar las reglas de conversión de un modelo E-R a un modelo relacional.
- Convertir su propio modelo E-R de DataLad (del Hito 1) en un esquema relacional completo.
- Digitalizar ese esquema y dejar registrado el avance hacia el **Hito 2** (semana 5).

**Equipo:** ______________________

---

## BLOQUE 1 — Formalización (2 horas, sin PC)

### Retomar el Hito 1

Tengan a la mano su diagrama E-R final de la Semana 1. Antes de empezar, respondan de memoria (sin mirar el diagrama):

**a)** ¿Cómo resolvieron ustedes la participación parcial entre EXPERIMENTO y MODELO?

_______________________________________________________________________________

### El modelo relacional

Completen la tabla de equivalencias mientras el docente explica:

| Término técnico | Equivalente en la analogía |
|---|---|
| Relación | |
| Tupla | |
| Atributo | |
| Dominio | |
| Grado | |
| Cardinalidad (de la tabla) | |

> ⚠️ **Atención con esta palabra:** "relación" significa algo distinto en el modelo E-R y en el modelo relacional. Antes de seguir, respondan:

**b)** En el modelo E-R (Semana 1), "relación" significa: _______________________________________________

**c)** En el modelo relacional (esta semana), "relación" significa: _______________________________________________

**d)** ¿La cardinalidad de una tabla (número de filas) es lo mismo que la cardinalidad E-R (1:1, 1:N, N:M)? Expliquen la diferencia con sus palabras.

_______________________________________________________________________________

### Reglas de conversión E-R → relacional

Anoten cada regla en sus propias palabras a medida que el docente las explica:

**Regla 1 — Entidad → tabla:**

_______________________________________________________________________________

**Regla 2 — Relación 1:N:**

_______________________________________________________________________________

**Regla 3 — Relación N:M:**

_______________________________________________________________________________

**Regla 4 — Atributo multivaluado:**

_______________________________________________________________________________

**Regla 5 — Entidad débil:**

_______________________________________________________________________________

**e)** ¿Por qué DataLab no tiene entidades débiles en su núcleo? ¿Alguna de las seis entidades depende de otra para existir?

_______________________________________________________________________________

### Ejercicio guiado en papel

Conviertan a mano, sobre su propio diagrama E-R del Hito 1, estas dos partes del modelo:

**a)** La relación N:M CIENTIFICO_DATOS–PROYECTO → dibujen la tabla puente resultante, con sus columnas.

**b)** La relación 1:N PROYECTO–EXPERIMENTO → indiquen en qué tabla queda la llave foránea y por qué.

*(Guarden esta hoja — la van a necesitar completa en el laboratorio.)*

### Tarea de transición

Antes del laboratorio, completen a mano la conversión de las tablas restantes: `dataset`, `experimento`, `modelo`, `metrica`, con todas sus columnas y llaves.

---

## BLOQUE 2 — Laboratorio (3 horas, con PC)

### Revisión cruzada (20 min)

Intercambien su conversión a mano con otro equipo por 5 minutos. Busquen un posible error y anótenlo como pregunta (no lo corrijan ustedes):

**Pregunta que le dejamos al otro equipo:** _______________________________________________

### Digitalización del esquema relacional (60 min)

Abran dbdiagram.io o MySQL Workbench (vista de modelado) y construyan las tablas completas de DataLab: `cientifico_datos`, `proyecto`, `dataset`, `experimento`, `modelo`, `metrica`, más las tablas puente que identificaron.

**Herramienta usada:** _______________________

> 💡 En dbdiagram.io, cada tabla se escribe así:
> ```
> Table experimento {
>   id_experimento int [pk]
>   id_proyecto int [ref: > proyecto.id_proyecto]
>   id_dataset int
>   fecha_ejecucion date
>   configuracion text
> }
> ```

### Descanso (15 min)

### Nombrar bien las tablas puente (40 min)

Para cada tabla puente que crearon, justifiquen el nombre elegido (no valen nombres genéricos como `tabla1`):

| Tabla puente | ¿Qué representa cada fila? | ¿Por qué se llama así? |
|---|---|---|
| | | |
| | | |

**Pregunta de cierre:** si borran una fila de su tabla puente `participacion` (o como la hayan llamado), ¿qué le pasa al científico? ¿y al proyecto?

_______________________________________________________________________________

### Documentación (30 min)

1. Actualicen `documentacion/diccionario_datos.md` al nivel lógico: cada tabla, sus columnas, tipo de dato preliminar, PK y FK.
2. Escriban en `documentacion/decisiones.md` por qué nombraron así sus tablas puente y qué atributos (si los hay) quedaron en ellas.

### Commit y cierre (15 min)

- Exporten el esquema a `diagramas/relacional/s02-esquema-relacional.png` (o el enlace de dbdiagram.io).
- Commit: `git commit -m "modelo: conversión de E-R a esquema relacional de DataLab"`.

> **Nota:** esto todavía no es el Hito 2 — ese llega en la Semana 5, después de normalizar el modelo y crearlo en un motor real. Por ahora es avance registrado.

---

## Verificación de comprensión — antes de salir

**1.** ¿Cuál es la diferencia entre "relación" en el modelo E-R y "relación" en el modelo relacional?

_______________________________________________________________________________

**2.** ¿Por qué la llave foránea de una relación 1:N va del lado "N" y no del lado "1"?

_______________________________________________________________________________

**3.** ¿Qué le pasaría al modelo de DataLab si CIENTIFICO_DATOS–PROYECTO fuera 1:N en vez de N:M?

_______________________________________________________________________________

---

## Avance hacia el Hito 2

- [ ] Esquema relacional completo digitalizado en `diagramas/relacional/s02-esquema-relacional.png`.
- [ ] Diccionario de datos actualizado a nivel lógico en `documentacion/diccionario_datos.md`.
- [ ] Decisiones sobre tablas puente registradas en `documentacion/decisiones.md`.
- [ ] Commit realizado con el mensaje sugerido.

*(El Hito 2 completo — normalización + creación en motor real — se cierra en la Semana 5.)*
