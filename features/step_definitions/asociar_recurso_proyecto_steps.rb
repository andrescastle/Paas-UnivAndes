# =  Asociar Recursos a un Proyecto

####################################################################################################
# ATENCION:
# TODOS LOS ESCENARIOS ESTAS EN PENDING
# ESTO ES PORQUE TOOS LS ESCENARIOS SE REALIZAN SOBRE LA INTERFAZ COMO TAB Y VISTAS EMERGENTES
# Y PARA ESTE CASO ES REQUERIDO IMPLEMENTAR ESCENARIOS QUE CUBRAN ESTS COMPONENTES
####################################################################################################

# Escenario No. 1
Dado /^que en asociar recursos a proyectos escenario 1 gestiono un proyecto en la pagina (.*)$/ do | pagina |

  pending #visit pagina
end

Entonces /^en asociar recursos a proyectos escenario 1 que aparezca una lista de recursos y una opcion de asociar un recurso de la lista/ do

  pending #page.should have_content( asociar_recurso )
end


# Escenario No. 2
Dado /^que en asociar recursos a proyectos escenario 2 gestiono un proyecto en la pagina (.*)$/ do | pagina |

  pending #visit pagina
end

Cuando /^en asociar recursos a proyectos escenario 2 asocio un recurso (.*)$/ do | recurso |

  pending #page.should have_content( asociar_recurso )
end

Y /^en asociar recursos a proyectos escenario 2 guardo el proyecto/ do

  pending
end

Entonces /^en asociar recursos a proyectos escenario 2 se espera en guardar proyecto ver el resultado (.*)$/ do | resultado |

  pending
end