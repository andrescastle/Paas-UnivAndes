# language: es
# =  Listar artefactos proyectos

####################################################################################################
# TODO:
# PROBAR COLUMNAS TIPO, IMAGEN
# PROBAR IMPLEMENTAR PRUEBAS DEFINIDAS EN LA HISTORIA
####################################################################################################

Característica: Listar Proyectos
    Como un usuario administrador de David
    quiero visualizar en forma de lista los artefactos de un proyecto 
    de forma que puede ver en una una lista su informacion como nombre, descripcion.
	
#Prueba de usuario
#Visualizar
  Esquema del escenario:
    Dado que en listar artefactos proyectos un usuario se encuentra en la ventana de <ventana>
    Cuando en listar artefactos proyectos ha creado el artefacto <artefacto>
    Entonces en listar artefactos proyectos se espera ver el resultado <resultado>

    Ejemplos:
    | ventana         	| artefacto     		| resultado	|
    | /proyectos		| imas_logo_large.jpeg  | OK		|
