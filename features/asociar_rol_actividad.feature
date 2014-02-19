# language: es
# =  HU_TP_Asociar Roles a una Actividad
Característica: Actividad
Como usuario que gestiona procesos
quiero asociar roles a una actividade
de forma que pueda definir que roles van a participar dicha actividad

# Escenario No. 1
  Esquema del escenario:
    Dado que en asociar roles a actividades escenario 1 gestiono una actividad en la pagina <pagina>
    Entonces en asociar roles a actividades escenario 1 que aparezca una lista de roles y una opcion de asociar un rol de la lista
  Ejemplos:
    | pagina | opcion |
    | /actividad | Editor |

# Escenario No. 2
  Esquema del escenario:
    Dado que en asociar roles a actividades escenario 2 gestiono una actividad en la pagina <pagina>
    Cuando en asociar roles a actividades escenario 2 asocio un rol <rol>
    Y en asociar roles a actividades escenario 2 guardo la actividad
    Entonces en asociar roles a actividades escenario 2 se espera en guardar actividad ver el resultado <resultado>
  Ejemplos:
    | pagina | rol | resultado |
    | /actividad | Dibujante | OK |
    | /actividad | Diseñador | OK |
