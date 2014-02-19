# language: es
# = Gestionar tiempo tareas

####################################################################################################
# TODO:
####################################################################################################

Característica: Usuarios
	Como usuario del sistema
	Y como persona que participa en proyectos
	Yo quiero gestionar el tiempo de una tarea asignada para mí
	De forma que visualice el tiempo planeado
	Y el tiempo real se asigne mediante opciones de aumentar o disminuir el tiempo estimado agregadas al campo de tarea junto al título de ésta

# Pruebas de persitencia
Esquema del escenario:
	Dado que en gestionar soy usuario <nombre>
	Cuando en gestionar estoy en la pagina <pagina>
	Y en gestionar consulto la tarea <tarea>
	Y la duracion <duracion_1>
	Y ahora la duracion es <duracion_2>
	Entonces se espera que se muestre la duracion <duracion_2>
	Y NO la duracion <duracion_2>

  Ejemplos:
    | nombre	| pagina	| tarea		| duracion_1	| duracion_2	|
    | juan		| proyectos	| dibujar	| 5				| 6				|
    | leidy		| proyectos	| modelar	| 6				| 7				|

