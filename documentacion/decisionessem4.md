# Decisiones de Diseño — Base de Datos

## 1. Políticas `ON DELETE` de las claves foráneas

| # | Relación (FK → Referenciada) | ON DELETE | Justificación |
|---|-------------------------------|-----------|----------------|
| 1 | `participa.cientifico_datos_id` → `cientifico_datos.id` | **CASCADE** | `participa` es una tabla de unión (científico–proyecto). Si se elimina un científico, sus registros de participación pierden sentido y deben eliminarse junto con él. |
| 2 | `participa.proyectos_id` → `proyectos.id` | **CASCADE** | Igual lógica: si se elimina un proyecto, las participaciones asociadas a ese proyecto ya no tienen razón de existir y se eliminan automáticamente. |
| 3 | `experimentos.cientifico_datos_id` → `cientifico_datos.id` | **RESTRICT** | Un experimento es un registro de valor (resultados, datos generados). No se permite borrar un científico si todavía tiene experimentos asociados, para evitar pérdida accidental de información científica y preservar la trazabilidad de autoría. |
| 4 | `experimentos.proyectos_id` → `proyectos.id` | **RESTRICT** | Por la misma razón: un proyecto no puede eliminarse mientras tenga experimentos vinculados, protegiendo los resultados generados dentro de ese proyecto. |
| 5 | `modelos.experimentos_id` → `experimentos.id` | **CASCADE** | Un modelo depende completamente de su experimento de origen; no tiene sentido conservar un modelo huérfano si el experimento que lo generó se elimina. |
| 6 | `metrica.modelos_id` → `modelos.id` | **CASCADE** | Una métrica no existe de forma independiente: mide el desempeño de un modelo específico. Si el modelo se elimina, sus métricas se eliminan con él. |
| 7 | `usa.experimentos_id` → `experimentos.id` | **CASCADE** | `usa` es tabla de unión (experimento–dataset). Al eliminar un experimento, los registros de uso de datasets asociados a él pierden sentido y se eliminan en cascada. |
| 8 | `usa.dataset_id` → `dataset.id` | **RESTRICT** | Un dataset puede estar siendo usado por varios experimentos simultáneamente. No se permite eliminarlo mientras esté en uso, para no romper la trazabilidad de qué datos respaldan qué resultados. |

**Criterio general aplicado:**
- **CASCADE** se usó en relaciones de dependencia total / tablas de unión, donde el registro dependiente no tiene existencia propia sin su "padre" (`participa`, `usa`, `modelos`, `metrica`).
- **RESTRICT** se usó donde el registro referenciado representa una entidad de valor propio que no debe desaparecer accidentalmente mientras existan registros históricos/científicos que dependan de ella (`cientifico_datos`, `proyectos`, `dataset`).
- `ON UPDATE` se dejó sin modificar (comportamiento por defecto) en las 8 relaciones, ya que no se identificó un caso de negocio que requiriera propagar cambios de clave primaria.

---

## 2. Auditoría de normalización

### Qué se revisó
- Que cada tabla represente una única entidad o concepto (científicos, proyectos, experimentos, modelos, métricas, datasets, y las tablas de unión `participa` y `usa`).
- Que cada columna no clave dependa completamente de la clave primaria de su tabla (2FN).
- Que no existan dependencias transitivas entre columnas no clave (3FN).
- Que las relaciones muchos-a-muchos (científico↔proyecto, experimento↔dataset) estén resueltas mediante tablas intermedias en lugar de columnas repetidas o multivaluadas.
- Que no haya duplicación de datos entre tablas (por ejemplo, datos de científico repetidos en `experimentos` en vez de referenciados por FK).
- Que las claves foráneas y tipos de datos sean consistentes entre tabla origen y tabla referenciada.

### Qué se confirmó
- Todas las tablas cumplen 1FN: no hay atributos multivaluados ni grupos repetitivos (por ejemplo, cada experimento tiene una única fila con su resultado, no una lista embebida).
- Se confirmó 2FN y 3FN en todas las tablas: los atributos no clave dependen únicamente de la clave primaria y no hay dependencias transitivas (ej. `area` depende solo de `proyectos.id`, no de otra columna no clave).
- La relación científico–proyecto está correctamente modelada mediante la tabla `participa`, evitando una FK múltiple o repetida en `cientifico_datos` o `proyectos`.
- La relación experimento–dataset está correctamente modelada mediante la tabla `usa`, por la misma razón.
- No se encontraron columnas duplicadas ni datos redundantes entre tablas relacionadas.

### Qué se ajustó
- No fue necesario modificar la estructura de tablas ni columnas: el modelo ya estaba en 3FN.
- El único ajuste realizado en esta fase fue a nivel de integridad referencial: definir explícitamente la política `ON DELETE` (CASCADE o RESTRICT) en las 8 relaciones, ya que por defecto Workbench no fuerza una decisión y esto quedaba ambiguo en el modelo original.

---

*Documento generado como parte del proceso de configuración del modelo relacional en MySQL Workbench.*
