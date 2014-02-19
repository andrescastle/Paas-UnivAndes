# language: es
# = Instanciar Actividad en Proceso
Característica: Proceso
Como usuario que gestiona procesos
quiero  definir los datos de instanciación de una actividad en mi flujo de proceso
de forma que la actividad del proceso tenga información asociada que la identifique en el flujo de proceso

####################################################################################################
# TODO: VERIFICAR CONTRA PRUEBA CREAR ACTIVIDAD
# 
####################################################################################################

# Creacion de actividades
  Esquema del escenario: 
    Dado que en instanciar una actividad creo una actividad con nombre <nombre> descripcion <descripcion> imagen de icono <imagen> modo de ejecucion <modo> rol <rol> responsable <responsable> y tipo de recurso <tipo_recurso>
    Cuando en instanciar una actividad se guarde la actividad
    Entonces en instanciar una actividad se espera ver <resultado>
 
  Ejemplos:
    | nombre        | descripcion               | imagen        | modo  | resultado     |
    #| actividad_1   | esta es la actividad 1    |    |      | OK            |
    | actividad_2 | | imagen1.jpg | 1 | OK |
    #| actividad_3 | esta es la actividad 3 | | 1 | OK |
    #| actividad_4 | esta es la actividad 4 | imagen1.jpg | | KO |
    | | esta es la actividad 5 | imagen1.jpg | 1 | KO |
    | actividad_1 | esta es la actividad 4 | imagen1.jpg | 1 | OK |
    | actividad_4 | esta es la actividad 4 | imagen1.jpg | 1 | OK |
    | actividad_5 | esta es la actividad 5 | imagen6.app | 1 | KO |

    # Actividad OK
    # Actividad OK sin descripcion
    # Actividad OK sin imagen
    # Actividad SIN MODO
    # Actividad SIN NOMBRE
    # Actividad REPETIDA
    # Actividad OK
    # Actividad CON IMAGEN INVALIDA
