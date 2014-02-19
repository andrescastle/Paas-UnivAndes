# language: es
# =  HU_TP_Pintar BPMN con flujo de ejemplo
Característica: Plantillas
Como usuario que gestiona procesos
quiero visualizar un diagrama BPM
de forma que pueda ver gráficamente el flujo diseñado.

# Escenario No. 1
  Esquema del escenario:
    Dado que en pintar bpm gestiono plantillas en la pagina <pagina>
    Y en pintar bpmhe creado una plantilla
    Cuando en pintar bpm abro la vista de disenno de proceso
    Entonces se espera que aparezca una vista con un diagrama BPM mostrando un proceso con todos sus elementos de acuerdo a la notacion BPMN
  Ejemplos:
    | pagina | opcion |
    | /plantillas | CostoTipoRec |
