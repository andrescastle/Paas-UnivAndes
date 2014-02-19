# language: es
# =  HU_CR_Crear un Recurso (sto379)
Característica: Recursos
Como usuario que gestiona recursos
quiero crear un recurso
de forma que sea identificado de forma unica, y sea consultado, editado y usado en configuración de proyectos.

# Pruebas de persitencia
# Creacion de recursos validos
  Esquema del escenario: 
    Dado que he introducido un recurso con nombre: <nombre>
    Y que he seleccionado el tipo de recurso: <tipo_recurso>
    Y cuyo costo es: <costo>
    Y el numero de unidades es: <unidades>
    Y la resenia es: <descripcion>
    Cuando se guarde el recurso
    Entonces el resultado debe ser: <resultado>
 
  Ejemplos:
    | nombre                | tipo_recurso | costo     | unidades | descripcion | resultado |
    | Compaq presario XP    | 1            | 100       | 5        |             |   OK      |
#    | NVidia GForce 2000    | 1            | 200       | 4        |             |   OK      |
#    |                       | 1            | 300       | 2        |             |   Error   |
#    | Compaq presario XP    | 1            | 300       | 2        |             |   Error   |   

# Pruebas de usuario
# Visualizar el formulario
  Esquema del escenario: 
    Dado que un usuario se encuentra en la ventana de: <ventana>
    Cuando da click en el boton: <boton>
    Entonces se espera que se abra una ventana con la siguiente informacion: <info>

    Ejemplos:
    | ventana      | boton              | info                |
    | /recursos    | nuevo_recurso      | recurso_nombre      |


####################################################################################################
# TODO: VERIFICAR ESTE CASO DE PRUEBA
#	YA ESTA UN ESCENARIO DE CREACION DE RECURSO
#	NO RECONOCE EL ELEMENTO elemento2 AUNQUE EN LA VENTANA MODAL EXISTE COMO select id=
####################################################################################################

# Pruebas de usuario
# Creacion de un recurso
   Esquema del escenario:
    Dado que un usuario se encuentra en la ventana de: <ventana>
    Cuando da click en el boton: <boton1>
    Y ha diligenciado el campo <elemento1> con la informacion: <texto1>
    Y ha seleccionado del campo <elemento2> la opcion: <texto2>
    Y ha diligenciado el campo <elemento3> con la informacion: <texto3>
    Y ha diligenciado el campo <elemento4> con la informacion: <texto4>
    Y ha diligenciado el campo <elemento5> con la informacion: <texto5>
    Y presiona el boton: <boton2>
    Entonces se espera que se muestre una ventana con la siguiente informacion: <info>

    Ejemplos:
    | ventana    | boton1         | elemento1      | texto1        | elemento2               | texto2       | elemento3     | texto3 | elemento4        | texto4 | elemento5            | texto5   | boton2        | info           |
#    | /recursos  | nuevo_recurso  | recurso_nombre | Dell_Desktop  | recurso_tipo_recurso_id | Licencia     | recurso_costo | 15615  | recurso_unidades | 2      | recurso_descripcion  | asdasdsa | crear_recurso | Dell_Desktop   |
#    | /recursos  | nuevo_recurso  | recurso_nombre | Dell_Desktop  | recurso_tipo_recurso_id | Licencia     | recurso_costo | 15615  | recurso_unidades | 2      | recurso_descripcion  | asdasdsa | crear_recurso | ya existe      |
#    | /recursos  | nuevo_recurso  | recurso_nombre |               | recurso_tipo_recurso_id | Licencia     | recurso_costo | 15615  | recurso_unidades | 2      | recurso_descripcion  | asdasdsa | crear_recurso | es obligatorio |
#    | /recursos  | nuevo_recurso  | recurso_nombre | Visual_Studio | recurso_tipo_recurso_id |              | recurso_costo | 15615  | recurso_unidades | 2      | recurso_descripcion  | asdasdsa | crear_recurso | es obligatorio |
#    | /recursos  | nuevo_recurso  | recurso_nombre | Adobe_Flash   | recurso_tipo_recurso_id | Licencia     | recurso_costo |        | recurso_unidades | 2      | recurso_descripcion  | asdasdsa | crear_recurso | es obligatorio |
#    | /recursos  | nuevo_recurso  | recurso_nombre | Adobe_CS3     | recurso_tipo_recurso_id | Licencia     | recurso_costo | asdasd | recurso_unidades | 2      | recurso_descripcion  | asdasdsa | crear_recurso | ser númerico   |

