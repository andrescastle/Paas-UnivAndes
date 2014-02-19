# language: es
# =  HU_TP_Asociar Tipos de Artefactos a una Actividad
Característica: Actividad
Como usuario que gestiona procesos
quiero asociar tipos de artefactos a una actividade
de forma que pueda definir que tipos de artefactos voy a necesitar para realizar dicha actividad

# Escenario No. 1
  Esquema del escenario:
    Dado que en asociar tipos de artefactos a actividades escenario 1 gestiono una actividad en la pagina <pagina>
    Entonces en asociar tipos de artefactos a actividades escenario 1 que aparezca una lista de tipos de artefactos y una opcion de asociar un tipo de artefacto de la lista
  Ejemplos:
    | pagina | opcion |
    | /tipo_artefactos | CostoTipoRec |

# Escenario No. 2
  Esquema del escenario:
    Dado que en asociar tipos de artefactos a actividades escenario 2 gestiono una actividad en la pagina <pagina>
    Cuando en asociar tipos de artefactos a actividades escenario 2 asocio un tipo de artefacto <tipo_artefacto>
    Y en asociar tipos de artefactos a actividades escenario 2 guardo la actividad
    Entonces en asociar tipos de artefactos a actividades escenario 2 se espera en guardar actividad ver el resultado <resultado>
  Ejemplos:
    | pagina | tipo_recurso | resultado |
    | /actividad | CostoTipoRec | OK |
    | /actividad | CostoTipoRec | KO |
