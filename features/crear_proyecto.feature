# language: es
# =  Crear un proyecto

####################################################################################################
# TODO:
# PROBAR CREAR CON CAMPOS TIPO, IMAGEN
####################################################################################################

Característica: Proyectos
 Como usuario con rol administrador de procesos
 quiero crear un proyecto 
 De forma que pueda asignarle un nombre, un tipo, una descripción.

# Pruebas de persitencia
# Creacion de proyectos validos
  Esquema del escenario: 
    Dado que he introducido un proyecto con nombre <nombre>
    Y para el proyecto he agregado descripcion <descripcion>
    Cuando se guarde el proyecto
    Entonces el resultado debe ser: <resultado>

  Ejemplos:
    | nombre	| descripcion 						| resultado	|
    | SBI		| Este es el proyecto de bocetos 	| OK |
    | REVISTA	| Este es el proyecto de reciclaje	| OK |
