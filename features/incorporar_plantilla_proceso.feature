# language: es
# = Incorporar Plantilla  Proceso
Característica: Proceso
Como usuario que gestiona procesos
quiero incorporar información de plantilla a un proceso
de forma que los datos de la plantilla sean tomados como base del proceso.

# Creacion de plantillas
  Esquema del escenario: 
    Dado que en incorporar creo un proceso con nombre <proceso> y una actividad <actividad>
    Cuando en incorporar asocie la actividad
    Entonces en incorporar se espera ver <resultado>
 
  Ejemplos:
    | proceso | actividad | resultado |
    | proceso_1 | actividad_1 | OK |
    
    # Proceso OK
