# language: es
# =  Crear una organizacion

####################################################################################################
# TODO:
####################################################################################################

Característica: Organizaciones
 Como usuario con rol administrador de procesos
 quiero crear una organizacion 
 De forma que pueda asignarle un nombre, una direccion de correo, un nit, un tipo.

# Pruebas de persitencia
# Creacion de usuarios validos
  Esquema del escenario: 
    Dado que he introducido una organizacion con nombre <nombre>
    Y es una organizacion con direccion <direccion>
    Y es una organizacion con nit <nit>
    Cuando se guarde la organizacion
    Entonces el resultado debe ser: <resultado>

  Ejemplos:
    | nombre		| direccion			| nit		| resultado	|
    | Casa Sanson	| arrayanes@yo.com	| 1234567	| KO |
    | Casa Sanson	| arrayanes@yo.com	| 1234568	| OK |

