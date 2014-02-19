# language: es
# =  Ver tareas asignadas

####################################################################################################
# TODO:
####################################################################################################

Característica: Usuarios
	Como usuario del sistema y de razuna
	Yo quiero usar razuna
	De forma que con mi usuario y clave de CMS entro a razuna transparentemente

# Pruebas de persitencia
Esquema del escenario:
	Dado que en autenticarme en razuna soy el usuario <nombre>
	Y en autenticarme en razuna tengo clave <clave>
	Cuando en autenticarme en razuna entro
	Entonces en autenticarme en razuna se espera el resultado <resultado>

  Ejemplos:
    | nombre		| clave		| resultado |
    | Administrator	| m6c6r3n6d	| OK |
    | admindavid	| 123456	| OK |
    | juan			| Test1		| KO |
