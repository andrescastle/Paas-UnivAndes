# language: es
# Source: http://github.com/aslakhellesoy/cucumber/blob/master/examples/i18n/es/features/adicion.feature
# Updated: Tue May 25 15:51:46 +0200 2010
Característica: Listar Recursos
    Como usuario que gestiona recursos
    Yo quiero consultar una lista de de recursos
    De forma que vea qué recursos existen

  Esquema del escenario: Listar recursos
    Dado que en recursos desde otra vista antes he introducido <recurso_1>
    Y en recursos desde otra vista estoy en la vista <pagina>
    Y en recursos desde otra vista introduzco la vista /recursos
    Entonces se espera en recursos desde otra vista ver <resultado1>

  Ejemplos:
    | pagina | recurso_1 | resultado1 |
    | /archivos | iMac | iMac |
