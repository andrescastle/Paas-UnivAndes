# language: es
# = Importar artefactos Dropbox

####################################################################################################
# TODO:
####################################################################################################

Característica: Artefactos
	Como usuario del sistema
	Yo quiero importar artefactos desde Dropbox
	De forma que esos artefactos me aparezcan en razuna

# Pruebas de persitencia
Esquema del escenario:
	Dado que en importar desde Dropbox soy el usuario <nombre>
	Y en importar desde Dropbox tengo clave <clave>
	Cuando en importar desde Dropbox importo artefactos
	Entonces en importar desde Dropbox se espera el resultado <resultado>

  Ejemplos:
    | nombre		| clave		| resultado |
    | admindavid	| 123456	| OK |
