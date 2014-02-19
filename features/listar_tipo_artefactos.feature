# language: es
# =  Listar tipos de artefactos

####################################################################################################
# TODO:
# PROBAR IMPLEMENTAR PRUEBAS DEFINIDAS EN LA HISTORIA
####################################################################################################

Característica: Listar Tipos de Artefactos
    Como un usuario con rol administrador de David
    quiero visualizar en forma de lista los tipos de artefactos que pueden crearse en la aplicación 
    de forma que puede ver en una una lista una columna su nombre y descripción
	Además los tipos de artefactos debe estar ordenados alfabéticamente por su nombre por defecto.
	
#Prueba de usuario
#Visualizar
  Esquema del escenario:
    Dado que en tipos de artefactos un usuario se encuentra en la ventana de <ventana>
    Cuando en listar tipos de artefactos aplica la opcion <boton>
    Entonces en listar tipos de artefactos se espera ver una tabla que tiene una columna <columna1>
    Y con una opcion en listar tipos de artefactos <opcion1>

    Ejemplos:
    | ventana         	| boton           	| columna1 				| opcion1               |
    | /tipo_artefactos  | tipo_artefactos  | Nombre tipo de artefacto   	| Crear tipo de artefacto |

####################################################################################################
# TODO:
####################################################################################################

#Prueba de usuario
#Visualizar un tipo de artefacto creado
  Esquema del escenario:
    Dado que en listar tipos de artefactos un usuario se encuentra en la ventana de <ventana>
    Cuando crea un tipo de artefacto con nombre <nombre1>
    Y crea otro tipo de artefacto con nombre <nombre2>
    Y en listar tipos de artefactos al regresar a la ventana <ventana>
    Entonces en listar tipos de artefactos se espera ver una lista con el valor <nombre1>
    Y el valor en listar tipos de artefactos <nombre2>

  Ejemplos:
    | ventana       		| nombre1  	| nombre2 |
    | /tipo_artefactos 		| Boceto 	| Archivo de sonido  |
