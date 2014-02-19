# language: es
# =  HU_TP_Crear un Tipo de Plantilla
Característica: Tipo de Plantilla
Como usuario que gestiona procesos
quiero crear un tipo de plantilla
de forma que sea identificado de forma unica, y sea consultado, editado y usado en gestion de plantillas

# Creacion de tipos de plantilla
  Esquema del escenario: 
    Dado que en tipos de plantillas creo un tipo de plantilla con nombre <nombre> y descripcion <descripcion>
    Cuando en tipos de plantillas se guarde el tipo de plantilla
    Entonces en tipos de plantillas se espera ver <resultado>
 
  Ejemplos:
    | nombre | descripcion | resultado |
    | tipo_1 | este es el tipo No. 1 | OK |
    | tipo_2 | | OK |
    | | este es el tipo No. 2 | KO |
    #| tipo_1 | este es el tipo No. 2 | KO |
    | tipo_2 | este es el tipo No. 2 | OK |

    # Tipo de plantilla OK
    # Tipo de plantilla OK sin descripcion
    # Tipo de plantilla sin nombre
    # Tipo de plantilla con nombre repetido
    # Tipo de plantilla OK
