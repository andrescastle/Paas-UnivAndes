# language: es
# =  Listar proyectos

####################################################################################################
# TODO:
# PROBAR COLUMNAS TIPO, IMAGEN
# PROBAR IMPLEMENTAR PRUEBAS DEFINIDAS EN LA HISTORIA
####################################################################################################

Característica: Listar Proyectos
    Como un usuario administrador de David
    quiero visualizar en forma de lista los proyectos de la aplicación 
    de forma que puede ver en una una lista su informacion como nombre, tipo, descripcion.
	
#Prueba de usuario
#Visualizar
  Esquema del escenario:
    Dado que en proyectos un usuario se encuentra en la ventana de <ventana>
    Cuando en listar proyectos aplica la opcion <boton>
    Entonces en listar proyectos se espera ver una tabla que tiene una columna <columna1>
    Y con una opcion en listar proyectos <opcion1>

    Ejemplos:
    | ventana         	| boton           	| columna1 				| opcion1               |
    | /proyectos		| nuevo_proyecto  	| nombre		   		| Crear proyecto		|

####################################################################################################
# TODO:
# PROBAR COLUMNAS TIPO, IMAGEN
# VERIFICAR PASO COMENTADO PORQUE CREA EL PROYECTO PERO MUESTRA ERROR
####################################################################################################

#Prueba de usuario
#Visualizar un tipo de artefacto creado
  Esquema del escenario:
    Dado que en proyectos un usuario se encuentra en la ventana de <ventana>
    #Cuando crea un proyecto con nombre <nombre1>
    Y crea un proyecto con nombre <nombre2>
    Y en listar proyectos al regresar a la ventana <ventana>
    Entonces en listar proyectos se espera ver una lista con el valor <nombre1>
    Y el valor en listar proyectos <nombre2>

  Ejemplos:
    | ventana			| nombre1  	| nombre2	|
    | /proyectos 		| SBI	 	| REVISTA	|
