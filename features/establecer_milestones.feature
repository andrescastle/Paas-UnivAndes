# language: es
# =  Listar actividades proyectos

####################################################################################################
# TODO:
# PROBAR INTERFAZ
####################################################################################################

Característica: Listar Proyectos
    Como un usuario administrador de David
    quiero establecer milestones a actividades 
    de forma que las tareas tengan fecha de terminacion o sean consideradas como hitos.
	
#Prueba de usuario
#Visualizar
  Esquema del escenario:
    Dado que en milestones tengo la actividad <actividad>
    Cuando marco la opcion hito
    Entonces en milestones se espera ver el resultado <resultado>

    Ejemplos:
    | actividad         	| resultado	|
    | Actividad 1			| OK		|
