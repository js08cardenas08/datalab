# Decisiones 

**Decisiones tomadas**


**EXPERIMENTO se modela como entidad**, porque tiene información propia como fecha de ejecución y configuración.


**ALGORITMO se modela como atributo de MODELO**, porque describe el algoritmo utilizado por el modelo y no necesita existir como entidad independiente.


**DATASET se modela como entidad fuerte**, porque puede identificarse de manera independiente y puede ser reutilizado en diferentes experimentos.


**CIENTIFICO_DATOS y PROYECTO tienen una relación N**, porque un científico de datos puede participar en varios proyectos y un proyecto puede tener varios científicos de datos.


**DATASET y EXPERIMENTO tienen una relación 1**, porque un dataset puede utilizarse en varios experimentos, mientras que cada experimento utiliza un dataset.


**EXPERIMENTO y MODELO tienen una relación 1:0..1,** porque un experimento puede no producir un modelo si no es exitoso, pero cuando produce uno, produce como máximo un modelo.


**MODELO y METRICA tienen una relación 1**, porque un modelo puede evaluarse con una o varias métricas y cada registro de métrica corresponde a un modelo.
