# =  Asociar costo a Tipo de Recurso
# Escenario No. 1
Dado /^que en asignar un costo a tipo de recurso gestiono un tipo de recurso en la pagina (.*)$/ do | pagina |

  visit '/tipo_recursos'
end

Y /^en asignar un costo a tipo de recurso aplica la opcion nuevo_tipo_recurso$/ do

  #pending
  click_link('nuevo_tipo_recurso')
end

Entonces /^en asignar un costo a tipo de recurso se espera en el tipo de recurso que aparezca la opcion (.*)$/ do | opcion |

# SE HA COMENTADO YA QUE ES UNA PRUEBA SOBRE UNA VENTANA MODAL
  	#page.should have_content(opcion)
	#with_scope(".jquery-ui-dialog-class") do
	
		#page.should have_content(opcion)
	#end  
end

# Escenario No. 2
Dado /^que en asignar un costo a tipo de recurso en esquema 2 gestiono un tipo de recurso en la pagina (.*)$/ do | pagina |

  visit '/tipo_recursos'
end

Cuando /^en asignar un costo a tipo de recurso en esquema 2 agrego un costo (.*) al tipo de recurso$/ do | costo |

    @tipoRecurso = TipoRecurso.new(:nombre => 'hola', :cost => costo, :unit => 1)
end

Y /^en asignar un costo a tipo de recurso en esquema 2 aplico la opcion de guardar tipo de recurso$/ do

	if(@tipoRecurso.save)
	
		@resultado = "OK"
	else
	
		@resultado = "KO"
	end
end

Entonces /^en asignar un costo a tipo de recurso en esquema 2 se espera como resultado (.*?)$/ do | resultado |

  if (@resultado != resultado)
  	raise("Fallo:" + resultado + ": eso fue lo que me salio y se esperaba " + @resultado)
  end
end

Y /^en asignar un costo a tipo de recurso en esquema 2 se espera en el tipo de recurso ver el costo (.*) agregado$/ do

  page.should have_content(costo)
end

# Escenario No. 3
Dado /^que en esquema 3 en asignar un costo a tipo de recurso gestiono un tipo de recurso en la pagina (.*)$/ do | pagina |

  #visit '/tipo_recursos'
  pending
end

Cuando /^en asignar un costo a tipo de recurso agrego al tipo de recurso un contenido no numerico (.*)$/ do | costo |

  #visit '/tipo_recursos'
  pending
end

Entonces /^en asignar un costo a tipo de recurso se espera que aparezca un (.*)$/ do | mensaje |
  
  #visit '/tipo_recursos'
  pending
end
