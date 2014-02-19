# language: es
# =  HU_TP_Visualizar tipos de plantillas en forma de lista
Característica: Tipo de Plantilla
    Como usuario que gestiona recursos
    Yo quiero consultar una lista de tipos de plantillas
    De forma que vea qu� tipos de plantillas existen

##Escenario mostrar una lista de tipos de plantillas visitando la pagina
#  Esquema del escenario: Listar tipos de plantillas
#    Dado que en tipos de plantillas estoy en la pagina <pagina>
#    Y en tipos de plantillas he introducido <tipo_plantilla_1> con descripcion <descripcion>
#    Entonces se espera en tipos de plantillas ver <resultado1>
#
#  Ejemplos:
#    | pagina | tipo_plantilla_1 | descripcion | resultado1 |
#    | /tipo_plantillas | tipo_1 | este es un tipo | tipo_1 |

#Escenario mostrar una lista de tipos de plantillas desde menu desde otra pagina
  Esquema del escenario: Listar tipos de plantillas
    Dado que en tipos de plantillas desde menu antes he introducido <tipo_plantilla_1> con descripcion <descripcion>
    Y en tipos de plantillas desde menu estoy en la pagina <pagina>
    Y en tipos de plantillas desde menu uso la opcion de ver tipos de plantillas
    Entonces se espera en tipos de plantillas desde menu ver <resultado1>

  Ejemplos:
    | pagina | tipo_plantilla_1 | descripcion | resultado1 |
    | /recursos | tipo_1 | este es un tipo | tipo_1 |