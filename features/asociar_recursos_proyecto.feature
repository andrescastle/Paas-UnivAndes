# language: es
# =  Asociar Recursos a un Proyecto
Característica: Proyecto
Como usuario que gestiona proyectos
quiero asociar recursos a un proyecto
de forma que pueda definir que recursos van a usarse en el proyecto

####################################################################################################
# TODO:
# ESCRIBIR ESCENARIOS PARA ACUERDOS DE INTERFAZ
####################################################################################################
# Escenario No. 1
  Esquema del escenario:
    Dado que en asociar recursos a proyecto escenario 1 gestiono un proyecto en la pagina <pagina>
    Entonces en asociar recursos a proyecto escenario 1 que aparezca una lista de roles y una opcion de asociar un recurso de la lista
  Ejemplos:
    | pagina | opcion |
    | /proyecto | Equipo Mac |

# Escenario No. 2
  Esquema del escenario:
    Dado que en asociar recursos a proyectos escenario 2 gestiono un proyecto en la pagina <pagina>
    Cuando en asociar recursos a proyectos escenario 2 asocio un recurso <recurso>
    Y en asociar recursos a proyectos escenario 2 guardo el proyecto
    Entonces en asociar recursos a proyectos escenario 2 se espera en guardar proyecto ver el resultado <resultado>
  Ejemplos:
    | pagina | recurso | resultado |
    | /proyecto | Equipo Mac | OK |
    | /proyecto | iMac | OK |
