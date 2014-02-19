# language: es
# =  HU_TP_Asociar Costo a Tipo de Recurso
Característica: Tipo de Recurso
Como usuario que gestiona recursos
quiero asociar un costo estimado a un tipo de recurso
de forma que pueda tener un estimado del costo de la plantilla diseñada

# ESTE ES UN ESCENARIO DE PRUEBAS DE INTERFAZ. NO DESCOMENTAR
  Esquema del escenario: 
    Dado que en asignar un costo a tipo de recurso gestiono un tipo de recurso en la pagina <pagina>
    Y en asignar un costo a tipo de recurso aplica la opcion nuevo_tipo_recurso
    Entonces en asignar un costo a tipo de recurso se espera en el tipo de recurso que aparezca la opcion <opcion>
  Ejemplos:
    | pagina | opcion |
    | /tipo_recursos | tipo_recurso[cost] |

  Esquema del escenario:
    Dado que en asignar un costo a tipo de recurso en esquema 2 gestiono un tipo de recurso en la pagina <pagina>
    Cuando en asignar un costo a tipo de recurso en esquema 2 agrego un costo <costo> al tipo de recurso
    Y en asignar un costo a tipo de recurso en esquema 2 aplico la opcion de guardar tipo de recurso
    Entonces en asignar un costo a tipo de recurso en esquema 2 se espera como resultado <resultado>
    #Y en asignar un costo a tipo de recurso en esquema 2 se espera en el tipo de recurso ver el costo <costo> agregado
  Ejemplos:
    | pagina | costo | resultado | texto |
    | /tipo_recursos | 10 | OK | 10 |
    #| /tipo_recursos | j | KO | test |

# ESTE ES UN ESCENARIO DE PRUEBAS DE INTERFAZ. NO DESCOMENTAR
#  Esquema del escenario:
#    Dado que en esquema 3 en asignar un costo a tipo de recurso gestiono un tipo de recurso en la pagina <pagina>
#    Cuando en asignar un costo a tipo de recurso agrego al tipo de recurso un contenido no numerico <costo>
#    Entonces en asignar un costo a tipo de recurso se espera que aparezca un <mensaje>.
#  Ejemplos:
#    | pagina | costo | mensaje |
#    | /tipo_recursos | J | El costo debe ser un valor numerico |
