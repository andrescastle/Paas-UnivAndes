# language: es
# =  Crear un usuario

####################################################################################################
# TODO:
# PROBAR CREAR CON CAMPOS ROL, IMAGEN
# VERIFICAR LOGIN REPETIDO PORQUE LA VALIDACION SE HACE DESDE LA INTERFAZ
####################################################################################################

Característica: Usuarios
 Como usuario con rol administrador de procesos
 quiero crear un usuario 
 De forma que pueda asignarle un nombre, un login.

# Pruebas de persitencia
# Creacion de usuarios validos
  Esquema del escenario: 
    Dado que he introducido un usuario con nombre <nombre>
    Y login <login>
    Y password <password>
    Cuando se guarde el usuario
    Entonces el resultado debe ser: <resultado>

  Ejemplos:
    | nombre			| login		| password	| resultado	|
    | Juan Manuel		| juan		| 123456	| KO |
    | Leidy Alexandra	| leidy35	| 123456	| OK |

