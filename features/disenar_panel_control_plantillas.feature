# language: es
# =  HU_TP_Diseñar Panel de Control de Plantillas
Característica: Plantillas
Como usuario que gestiona procesos
quiero visualizar informacion consolidada de una plantilla
de forma que pueda ver las estadisticas más importantes de la plantilla

# Escenario No. 1
  Esquema del escenario:
    Dado que en disenar panel control plantillas gestiono plantillas en la pagina <pagina>
    Y en disenar panel control plantillas he creado una plantilla
    Cuando en disenar panel control plantillas consulto la plantilla
    Entonces en disenar panel control plantillas se espera que aparezca una vista con numero de actividades <actividades>
    Y en disenar panel control plantillas con numero de compuertas <compuertas>
    Y en disenar panel control plantillas con numero de recursos <recursos>
    Y en disenar panel control plantillas con tiempo <tiempo>
    Y en disenar panel control plantillas con costo <costo>

  Ejemplos:
    | pagina | actividades | compuertas | recursos | tiempo |  |
    | /plantillas | 1 | 1 | 1 | 1 | 1 |
