# language: es
# =  HU_TP_Crear Proceso
Característica: Proceso
Como usuario que gestiona procesos
quiero crear un proceso
de forma que  que los datos de la plantilla sean tomados como la base del nuevo proceso.

# Creacion de plantillas
  Esquema del escenario: 
    Dado que en procesos creo un proceso con nombre <nombre> tipo de plantilla <tipo_plantilla>
    Cuando en procesos se guarde el proceso
    Entonces en procesos se espera ver <resultado>
 
  Ejemplos:
    | nombre | tipo_plantilla | resultado |
    | proceso_1 | 1 | OK |
    |  | 1 | KO |
    
    # Proceso OK
    # Proceso SIN NOMBRE