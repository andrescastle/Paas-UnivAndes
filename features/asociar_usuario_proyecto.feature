# language: es
# =  Asociar Usuarios participantes en un Proyecto
Característica: Proyecto
Como usuario que gestiona proyectos
quiero asociar usuarios participantes a un proyecto
de forma que pueda asociarles tareas a desarrollar

# Escenario No. 1
  Esquema del escenario:
    Dado que en asociar usuarios participantes en un proyecto escenario 1 gestiono un proyecto en la pagina <pagina>
    Entonces en asociar usuarios participantes en un proyecto escenario 1 que aparezca una lista de usuarios y una opcion de asociar usuario
  Ejemplos:
    | pagina | opcion |
    | /proyectos | #participantes |

# Escenario No. 2
  Esquema del escenario:
    Dado que en asociar usuarios participantes en un proyecto escenario 2 gestiono un proyecto en la pagina <pagina>
    Cuando en asociar usuarios participantes en un proyecto escenario 2 asocio una usuario <usuario>
    Y en asociar usuarios participantes en un proyecto escenario 2 guardo el proyecto
    Entonces en asociar usuarios participantes en un proyecto escenario 2 se espera en guardar proyecto ver el resultado <resultado>
  Ejemplos:
    | pagina | usuario | resultado |
    | /proyectos | Juan | OK |
    | /proyectos | Leidy | OK |
