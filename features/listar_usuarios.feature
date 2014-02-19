# language: es
# =  Listar usuarios

####################################################################################################
# TODO:
# PROBAR IMPLEMENTAR PRUEBAS DEFINIDAS EN LA HISTORIA
####################################################################################################

Característica: Listar Usuarios
    Como un usuario administrador de David
    quiero visualizar en forma de lista los usuarios de la aplicación 
    de forma que puede ver en una una lista su informacion como nombre, login, rol.
	
#Prueba de usuario
#Visualizar
  Esquema del escenario:
    Dado que en usuarios un usuario se encuentra en la ventana de <ventana>
    Cuando en listar usuarios aplica la opcion <boton>
    Entonces en listar usuarios se espera ver una tabla que tiene una columna <columna1>
    Y con una opcion en listar usuarios <opcion1>

    Ejemplos:
    | ventana         	| boton           	| columna1 				| opcion1               |
    | /usuarios			| nuevo_usuario  	| nombre		   		| Nuevo usuario |

####################################################################################################
# TODO:
# CUANDO CREO UN STEP CON DOS PARAMETROS DICE UNDEFINED STEP
####################################################################################################

#Prueba de usuario
#Visualizar un tipo de artefacto creado
  Esquema del escenario:
    Dado que en listar usuarios un usuario se encuentra en la ventana de <ventana>
    Cuando crea un usuario con nombre <nombre1> 
    Y en listar usuarios doy login <login1>
    Y guardo el usuario
    Y crea otro usuario con nombre <nombre2>
    Y en listar usuarios doy login <login2>
    Y guardo el usuario
    Y en listar usuarios al regresar a la ventana <ventana>
    Entonces en listar usuarios se espera ver una lista con el valor <nombre1>
    Y el valor en listar usuarios <nombre2>

  Ejemplos:
    | ventana			| nombre1  	| login1	| nombre2 	| login2	|
    | /usuarios 		| Juan	 	| juan743	| Leidy	  	| leidy35	|
