# language: es
# = Importar artefactos Basecamp

####################################################################################################
# TODO:
####################################################################################################

Característica: Artefactos
	Como usuario del sistema
	Yo quiero importar artefactos desde Basecamp
	De forma que esos artefactos me aparezcan en razuna

# Pruebas de persitencia
Esquema del escenario:
	Dado que en importar desde Basecamp soy el usuario <nombre>
	Y en importar desde Basecamp tengo clave <clave>
	Cuando en importar desde Basecamp importo artefactos
	Entonces en importar desde Basecamp se espera el resultado <resultado>

  Ejemplos:
    | nombre		| clave		| resultado |
    | admindavid	| 123456	| OK |
