# language: es
# =  HU_TP_Crear una Compuerta
Característica: Compuerta
Como usuario que gestiona procesos
quiero crear una compuerta
de forma que un nombre, una descripción, un tipo de compuerta y un tipo de decision

####################################################################################################
# TODO: VERIFICAR ESTE ESCENARIO
#
# AL PERSISTIR LA COMPUERTA DESDE LA PRUEBA NO GENERA OK AUNQUE LA INFORMACION Y EL MODELO ESTAN OK
# OK DESDE LA INTERFAZ
# OK DESDE SQL 
#
# DESCONTINUADO POR
# Sprint 6: Historia Diseñar árbol de flujo de procesos, 
# 
####################################################################################################

# Creacion de compuertas
  Esquema del escenario: 
    Dado que en crear una compuerta creo una compuerta con nombre <nombre> descripcion <descripcion> tipo de compuerta <tipo_compuerta> y tipo de decision <tipo_decision>
    Cuando en crear una compuerta se guarde la compuerta
    Entonces en crear una compuerta se espera ver <resultado>
 
  Ejemplos:
    | nombre | descripcion | tipo_compuerta | tipo_decision | resultado |
    | compuerta_1 | esta es la compuerta_ 1 | 1 | 1 | OK |
    | compuerta_2 | | 1 | 1 | OK |
    | | esta es la compuerta_3 | 1 | 1 | KO |
    | compuerta_1 | esta es la compuerta_3 | 1 | 1 | KO |
    | compuerta_3 | esta es la compuerta_3 | 1 | 1 | OK |

    # Compuerta OK
    # Compuerta OK sin descripcion
    # Compuerta SIN NOMBRE
    # Compuerta REPETIDA
    # Compuerta OK
