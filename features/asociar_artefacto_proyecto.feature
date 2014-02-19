# language: es
# = Asociar Artefactos (Assets) existentes a un Proyecto
Característica: Proyecto
Como artefacto que gestiona proyectos
quiero asociar artefactos participantes a un proyecto
de forma que cuente con artefactos que se utilizaran en el proyecto

# Escenario No. 1
  Esquema del escenario:
    Dado que en asociar artefactos a un proyecto escenario 1 gestiono un proyecto en la pagina <pagina>
    Entonces en asociar artefactos a un proyecto escenario 1 que aparezca una lista de artefactos y una opcion de asociar artefacto
  Ejemplos:
    | pagina | opcion |
    | /proyectos | #artefactos |

# Escenario No. 2
  Esquema del escenario:
    Dado que en asociar artefactos a un proyecto escenario 2 gestiono un proyecto en la pagina <pagina>
    Cuando en asociar artefactos a un proyecto escenario 2 asocio un artefacto <artefacto>
    Y en asociar artefactos a un proyecto escenario 2 guardo el proyecto
    Entonces en asociar artefactos a un proyecto escenario 2 se espera en guardar proyecto ver el resultado <resultado>
  Ejemplos:
    | pagina | artefacto | resultado |
    | /proyectos | iMac | OK |
    | /proyectos | JDK 7 | OK |