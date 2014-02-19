# language: es
# =  HU_TP_Asociar Tipos de Recursos a una Actividad
Característica: Actividad
Como usuario que gestiona procesos
quiero asociar tipos de recursos a una actividad
de forma que pueda definir que recursos voy a necesitar para realizar dicha actividad

# Escenario No. 1
  Esquema del escenario:
    Dado que en asociar tipos de recursos a actividades escenario 1 gestiono una actividad en la pagina <pagina>
    Entonces en asociar tipos de recursos a actividades escenario 1 que aparezca una lista de tipos de recursos y una opcion de asociar un tipo de recurso de la lista
  Ejemplos:
    | pagina | opcion |
    | /tipo_recursos | CostoTipoRec |

# Escenario No. 2
  Esquema del escenario:
    Dado que en asociar tipos de recursos a actividades escenario 2 gestiono una actividad en la pagina <pagina>
    Cuando en asociar tipos de recursos a actividades escenario 2 asocio un tipo de recurso <tipo_recurso>
    Entonces en asociar tipos de recursos a actividades escenario 2 se espera que aparezca una opcion de agregar el numero de instancias o unidades de ese tipo de recurso
    Y en asociar tipos de recursos a actividades escenario 2 que aparezca en numero de instancias 1 por defecto
  Ejemplos:
    | pagina | tipo_recurso |
    | /actividad | CostoTipoRec |

# Escenario No. 3
  Esquema del escenario:
    Dado que en asociar tipos de recursos a actividades escenario 3 gestiono una actividad en la pagina <pagina>
    Cuando en asociar tipos de recursos a actividades escenario 3 asocio un tipo de recurso <tipo_recurso>
    Y en asociar tipos de recursos a actividades escenario 3 agrego numero de instancias <instancias>
    Y en asociar tipos de recursos a actividades escenario 3 guardo la actividad
    Entonces en asociar tipos de recursos a actividades escenario 3 se espera en guardar actividad ver el resultado <resultado>
  Ejemplos:
    | pagina | tipo_recurso | instancias | resultado |
    | /actividad | CostoTipoRec | 2 | OK |
    | /actividad | CostoTipoRec | | KO |
