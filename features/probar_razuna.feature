# language: es
# =  Ver tareas asignadas

####################################################################################################
# TODO:
####################################################################################################

Característica: Usuarios
	Como usuario del sistema
	Yo quiero probar razuna
	De forma que haga las cosas desde la prueba

# Pruebas de persitencia
Esquema del escenario:
	Dado que soy el usuario <nombre>
	Cuando visito la pagina <pagina>
	Entonces se espera una respuesta

  Ejemplos:
    | nombre	| pagina	| 
    | juan		| http://pruebasdavid.virtual.uniandes.edu.co:8080/razuna/global/api2/folder.cfc?method=getfolder&api_key=8F852FE7C05B44528D696CA9A08125AA&folderid=067A56D20F264918AA66D729C46652D8 |
