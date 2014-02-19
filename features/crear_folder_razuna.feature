# language: es
# =  Ver tareas asignadas

####################################################################################################
# TODO:
# ¿FOLDER CORRESPONDE A REPOSITORIO O TIPO DE ARTEFACTO?
####################################################################################################

Característica: Usuarios
	Como usuario del sistema y de razuna
	Yo quiero crear un folder en razuna
	De forma que aparezca en mi sesion de razuna

# Pruebas de persitencia
Esquema del escenario:
	Dado que en crear folder soy el usuario <nombre>
	Cuando en crear folder creo el folder <folder>
	Entonces en crear folder se espera el resultado <resultado>

  Ejemplos:
    | nombre	| folder	| resultado |
    | juan		| Test1		| OK |
    | juan		| Test2		| OK |
    | juan		| Test1		| KO |
