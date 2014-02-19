# language: es
# =  HU_TP_Asociar Duracion a una Actividad
Característica: Tipo de Recurso
Como usuario que gestiona procesos
quiero asociar una duracion a una actividad
de forma que  que pueda tener un estimado de la duración de la plantilla diseñada

# Escenario No. 1
  Esquema del escenario: 
    Dado que en agregar duracion a una actividad gestiono una actividad en la pagina <pagina>
    Entonces en agregar duracion a una actividad se espera en la actividad que aparezca la opcion <opcion>
  Ejemplos:
    | pagina | opcion |
    | /actividades | duracion |

# Escenario No. 2
  Esquema del escenario:
    Dado que en esquema 2 en agregar duracion a una actividad gestiono una actividad en la pagina <pagina>
    Cuando en agregar duracion a una actividad agrego una duracion <duracion> a la actividad
    Y en agregar duracion a una actividad aplico la opcion de guardar actividad
    Entonces en agregar duracion a una actividad se espera en la actividad ver la duracion <duracion> agregada
  Ejemplos:
    | pagina | duraacion |
    | /actividades | 10 |

# Escenario No. 3
  Esquema del escenario:
    Dado que en esquema 3 en agregar duracion a una actividad gestiono una actividad en la pagina <pagina>
    Cuando en agregar duracion a una actividad agrego a la actividad un contenido no numerico <duracion>
    Entonces en agregar duracion a una actividad se espera que aparezca un <mensaje>
  Ejemplos:
    | pagina | duracion | mensaje |
    | /tipo_recursos | J | La duracion debe ser un valor numerico |
