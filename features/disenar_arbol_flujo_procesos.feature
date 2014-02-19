# language: es
# =  HU_TP_Diseñar Arbol de Flujo de Procesos
Característica: Plantillas
Como usuario que gestiona procesos
quiero disenar un proceso en un arbol de navegacion
de forma que  pueda crear nuevas actividades y compuertas

# Escenario No. 1
  Esquema del escenario:
    Dado que en disenar arbol flujo procesos E1 aplico la opcion de crear hoja diseno un arbol de flujo de procesos en la pagina <pagina>
    Entonces en disenar arbol flujo procesos E1 se espera que aparezca una vista con opciones de agregar o eliminar hojas
  Ejemplos:
    | pagina |
    | /plantillas |

# Escenario No. 2
  Esquema del escenario:
    Dado que en disenar arbol flujo procesos E2 diseno un arbol de flujo de procesos en la pagina <pagina>
    Cuando en disenar arbol flujo procesos E2 aplico la opcion de crear hoja
    Entonces en disenar arbol flujo procesos E2 se espera que aparezca una vista de una actividad nueva con atributo nombre
    Y en disenar arbol flujo procesos E2 con atributo descripcion
    Y en disenar arbol flujo procesos E2 con atributo modo de ejecucion
    Y en disenar arbol flujo procesos E2 con atributo duracion
    Y en disenar arbol flujo procesos E2 con atributo imagen
    Y en disenar arbol flujo procesos E2 con una opcion de guardar actividad
  Ejemplos:
    | pagina |
    | /plantillas |

# Escenario No. 3
  Esquema del escenario:
    Dado que que en disenar arbol flujo procesos E3 diseno un arbol de flujo de procesos en la pagina <pagina>
    Cuando en disenar arbol flujo procesos E3 aplico la opcion de crear hoja
    Cuando en disenar arbol flujo procesos E3 creo una hoja con nombre <nombre> descripcion <descripcion> modo de ejecucion <modo> duracion <duracion> imagen <imagen>
    Y en disenar arbol flujo procesos E3 aplico la opcion de guardar
    Entonces en disenar arbol flujo procesos E3 se espera que en el arbol aparezca un elemento actividad con nombre <nombre>
  Ejemplos:
    | pagina | nombre | descripcion | modo | duracion | imagen |
    | /plantillas | actividad_1 | esta es una actividad | modo_1 | 20 | imagen1.jpg |
    | /plantillas | actividad_2 | esta es una actividad | modo_1 | | imagen1.jpg |

# Escenario No. 4
  Esquema del escenario:
    Dado que que en disenar arbol flujo procesos E4 diseno un arbol de flujo de procesos en la pagina <pagina>
    Cuando en disenar arbol flujo procesos E4 creo una hoja con nombre <nombre>
    Cuando en disenar arbol flujo procesos E4 creo una hoja con nombre <nombre> descripcion <descripcion> modo de ejecucion <modo> duracion <duracion> imagen <imagen>
    Y en disenar arbol flujo procesos E4 selecciono la hoja
    Entonces en disenar arbol flujo procesos E4 se espera que aparezca una hoja con nombre <nombre> descripcion <descripcion> modo de ejecucion <modo> duracion <duracion> imagen <imagen>
  Ejemplos:
    | pagina | nombre | descripcion | modo | duracion | imagen |
    | /plantillas | actividad_1 | esta es una actividad | modo_1 | 20 | imagen1.jpg |
    | /plantillas | actividad_2 | esta es una actividad | modo_1 | | imagen1.jpg |

# Escenario No. 5
  Esquema del escenario:
    Dado que que en disenar arbol flujo procesos E5 diseno un arbol de flujo de procesos en la pagina <pagina>
    Y en disenar arbol flujo procesos E5 he creado una hoja con nombre <nombre_anterior>
    Cuando en disenar arbol flujo procesos E5 creo una hoja con nombre <nombre> descripcion <descripcion> modo de ejecucion <modo> duracion <duracion> imagen <imagen>
    Entonces en disenar arbol flujo procesos E5 se espera que en el arbol aparezca la actividad nueva despues de la actividad anterior
  Ejemplos:
    | pagina | nombre_anterior | nombre | descripcion | modo | duracion | imagen |
    | /plantillas | actividad_0 | actividad_1 | esta es una actividad | modo_1 | 20 | imagen1.jpg |
    | /plantillas | actividad_0 | actividad_2 | esta es una actividad | modo_1 | | imagen1.jpg |
