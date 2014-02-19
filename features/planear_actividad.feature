# language: es
# =  Planear Actividad
Característica: Proyecto
Como usuario que gestiona procesos 
Yo quiero asociar participantes, recursos, y artefactos a una actividad de mi flujo de proceson 
De forma que pueda realizar una planeación del proceso

####################################################################################################
# TODO:
# ESCRIBIR ESCENARIOS PARA FECHAS
# ESCRIBIR ESCENARIOS PARA CALCULAR DURACION
# ESCRIBIR ESCENARIOS PARA VERIFICAR ACTIVIDADES CON RECURSOS
# ESCRIBIR ESCENARIOS PARA ACUERDOS DE INTERFAZ
####################################################################################################
# Escenario No. 1
  Esquema del escenario:
    Dado que en planear actividad voy a la vista <pagina>
    Y he disenado un proceso con la actividad <actividad>
    Entonces en planear actividad se espera que aparezca nombre <nombre>
    Y fecha <fecha>
    Y duracion <duracion>
    Y recursos <recurso1>, <recurso2>
  Ejemplos:
    | pagina 	| actividad 				| fecha 		| duracion 	| recurso1 	| recurso2 |
    | /procesos | Realizar lluvia de ideas 	| 2013-03-12	| 2			| lapices	| papeles |

# Escenario No. 2
  Esquema del escenario:
    Dado que en planear actividad voy a la vista <pagina>
    Y he disenado un proceso con la actividad <actividad>
    Y en planear actividad cambio la fecha a <fecha>
    Entonces en planear actividad se espera como resultado <resultado>
  Ejemplos:
    | pagina 	| actividad 				| fecha 		| resultado |
    | /procesos | Realizar lluvia de ideas 	| 2013-03-12	| OK |

# Escenario No. 3
  Esquema del escenario:
    Dado que en planear actividad voy a la vista <pagina>
    Y he disenado un proceso con la actividad <actividad>
    Y en planear actividad cambio el nombre a <nombre>
    Entonces en planear actividad se espera como resultado <resultado>
  Ejemplos:
    | pagina 	| actividad 				| nombre 		| resultado |
    | /procesos | Realizar lluvia de ideas 	| Brainstorming	| OK |

# Escenario No. 4
  Esquema del escenario:
    Dado que en planear actividad voy a la vista <pagina>
    Y he disenado un proceso con la actividad <actividad>
    Y en planear actividad cambio el responsable a <responsable>
    Entonces en planear actividad se espera como resultado <resultado>
  Ejemplos:
    | pagina 	| actividad 				| responsable 		| resultado |
    | /procesos | Realizar lluvia de ideas 	| Juan				| OK |
