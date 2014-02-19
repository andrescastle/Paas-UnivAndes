# language: es
# = Autenticarse

####################################################################################################
# TODO:
####################################################################################################

Característica: Usuarios
	Como usuario de DAVID
	Yo quiero hacer uso de las prestaciones de la herramienta
	De forma que dados mis roles asociados al ingresar DAVID tenga acceso permitido o no a cada una de las prestaciones de esta herramienta.

Esquema del escenario:
	Dado que soy un usuario registrado en el sistema 
	Cuando yo me autentico con el login <login>
	Y yo me autentico con la clave <clave>
	Entonces se espera al autenticarme el resultado <resultado>

  Ejemplos:
    | login		| clave		| resultado		|
    | juan		| juan123	| OK			|
    | juan		| juan124	| KO			|
    | leidy		| juan123	| KO			|

