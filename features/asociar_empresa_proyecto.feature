# language: es
# =  Asociar Empresa a un Proyecto
Característica: Proyecto
Como usuario que gestiona proyectos
quiero asociar empresas a un proyecto
de forma que pueda definir que empresas van a participar en el proyecto

####################################################################################################
# TODO:
# ESCRIBIR ESCENARIOS PARA ACUERDOS DE INTERFAZ
####################################################################################################
# Escenario No. 1
  Esquema del escenario:
    Dado que en asociar empresas a proyecto escenario 1 gestiono un proyecto en la pagina <pagina>
    Entonces en asociar empresas a actividades escenario 1 que aparezca una lista de empresas y una opcion de asociar una empresa de la lista
  Ejemplos:
    | pagina | opcion |
    | /proyecto | #empresas |

# Escenario No. 2
  Esquema del escenario:
    Dado que en asociar empresas a proyectos escenario 2 gestiono un proyecto en la pagina <pagina>
    Cuando en asociar empresas a proyectos escenario 2 asocio una empresa <recurso>
    Y en asociar empresas a proyectos escenario 2 guardo el proyecto
    Entonces en asociar empresas a proyectos escenario 2 se espera en guardar proyecto ver el resultado <resultado>
  Ejemplos:
    | pagina | recurso | resultado |
    | /proyecto | Colgames | OK |
    | /proyecto | ENNOVA | OK |
