# language: es
# =  Ver tareas asignadas

####################################################################################################
# TODO:
# PROBAR CON ARTEFACTOS Y CON ARTEFACTOS YA EN DAVID
####################################################################################################

Característica: Usuarios
	Como usuario del sistema y de razuna
	Yo quiero crear un folder en razuna
	De forma que aparezca en mi sesion de razuna

# Pruebas de persitencia
Esquema del escenario:
	Dado que en desplegar artefactos soy el usuario <nombre>
	Cuando en desplegar artefactos consulto el artefacto <artefacto>
	Entonces en desplegar artefactos se espera el resultado <resultado>

  Ejemplos:
    | nombre	| artefacto		| resultado |
    | juan		| artefacto1	| OK |
    | juan		| artefacto2	| KO |
