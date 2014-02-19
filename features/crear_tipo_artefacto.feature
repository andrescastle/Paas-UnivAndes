# language: es
# =  Crear un tipo de artefacto

####################################################################################################
# TODO:
####################################################################################################

Característica: Tipos de artefacto
 Como usuario con rol administrador de procesos
 quiero crear un tipo de recurso 
 De forma que pueda asignarle un nombre y una descripción.

# Pruebas de persitencia
# Creacion de tipos de recursos validos
  Esquema del escenario: 
    Dado que he introducido un tipo de artefacto con nombre <nombre>
    Y descripcion <descripcion>
    Cuando se guarde el tipo de artefacto
    Entonces el resultado debe ser: <resultado>

  Ejemplos:
    | nombre	| descripcion 			| resultado	|
    | Boceto	| Este es un boceto 	| OK |
    | Modelo 3D	| Este es un modelo 3D 	| OK |
    | Boceto	| Este es otro boceto|  | KO |  
