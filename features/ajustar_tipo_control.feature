# language: es
# =  Listar actividades proyectos

####################################################################################################
# TODO:
# PROBAR INTERFAZ
####################################################################################################

Característica: Listar Proyectos
    Como un usuario administrador de David
    quiero determinar el tipo de control a actividades 
    de haga un seguimiento al proceso de acuerdo al tipo de control.
	
#Prueba de usuario
#Visualizar
  Esquema del escenario:
    Dado que en milestones tengo la actividad <actividad>
    Cuando elijo el tipo de control <tipo_control>
    Entonces en milestones se espera ver el resultado <resultado>

    Ejemplos:
    | actividad         	| tipo_control	| resultado	|
    | Actividad 1			| 1				| OK		|
