# language: es
# =  HU_CR_Crear un tipo de Recurso (sto380)

####################################################################################################
# TODO:
# EXTENDER PARA AGREGAR TIPO CON COSTO Y UNIDAD
# AL MOMENTO DE IMPLEMENTAR LA HISTORIA SE TUVO EN CUENTA TIPO DE RECURSO CON SOLO NOMBRE
####################################################################################################

Característica: Tipos de recursos
 Como usuario con rol administrador de david
 quiero crear un tipo de recurso 
 De forma que sea identificado de forma unica, y sea consultado, editado y usado en configuracion de recursos.

# Pruebas de persitencia
# Creacion de tipos de recursos validos
  Esquema del escenario: 
    Dado que he introducido un tipo de recurso con nombre <nombre>
    Y costo <costo>
    Y unidades <unidades>
    Cuando se guarde el tipo de recurso
    Entonces el resultado debe ser: <resultado>

  Ejemplos:
    | nombre                | costo | unidades | resultado	|
    | Equipo de computo     | 1 | 1 | OK |
    | $%%$%GFGFGF           | 1 		| 1 		|   Error   |
    |                       | 1 		| 1 		|   Error   |
    | Dummy                 | 1 		| 1 		|   OK      |  

# Pruebas de usuario
# Visualizar el formulario
  Esquema del escenario:
    Dado que un usuario se encuentra en la ventana de: <ventana>
    Cuando presiona el boton: <boton>
    Entonces se espera que se abra una ventana con la siguiente informacion: <info>

    Ejemplos:
    | ventana           | boton                   | info                |
    | /tipo_recursos    | nuevo_tipo_recurso      | tipo_recurso_nombre |


####################################################################################################
# TODO: VERIFICAR ESTE CASO DE PRUEBA
#	YA ESTA UN ESCENARIO DE CREACION DE RECURSO AGREGANDO COSTO Y UNIDADES
#	SI RECONOCE EL ELEMENTO elemento EN LA VENTANA MODAL
####################################################################################################

# Pruebas de usuario
# Creacion de tipos de recursos
  Esquema del escenario:
    Dado que un usuario se encuentra en la ventana de: <ventana>
    Cuando da click en el boton: <boton1>
    Y ha diligenciado el campo <elemento> con la informacion: <texto>
    Y presiona el boton: <boton2>
    Entonces se espera que se muestre una ventana con la siguiente informacion: <info>

    Ejemplos:
    | ventana         | boton1              | elemento             | texto         | boton2             | info           |
    | /tipo_recursos  | nuevo_tipo_recurso  | tipo_recurso_nombre  | Computadores  | crear_tipo_recurso | Computadores   |
    | /tipo_recursos  | nuevo_tipo_recurso  | tipo_recurso_nombre  | Computadores  | crear_tipo_recurso | ya existe      |
    | /tipo_recursos  | nuevo_tipo_recurso  | tipo_recurso_nombre  |               | crear_tipo_recurso | es Obligatorio |

