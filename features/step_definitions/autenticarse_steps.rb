# = Autenticarse

####################################################################################################
# TODO:
####################################################################################################
# Asignacion de nombre
Dado /^que soy un usuario registrado en el sistema/ do

	@usuario = Usuario.new(
	:nombre => 'juan',
	:login => 'juan',
	:password => 'juan123')
	@usuario.save
end

Cuando /^yo me autentico con el login (.*)/ do | loginnombre |

	@login = loginnombre
end

Y /^yo me autentico con la clave (.*)/ do | clave |

	@password = clave
end

Entonces /^se espera al autenticarme el resultado (.*)/ do | expecting |

	@usuarios = Usuario.all
    @resultado = "KO"
    @usuarios.each do | usuariotmp |
    
    	if @resultado == "KO"
    	
			if usuariotmp.login == @login
				
				if usuariotmp.password == @password
					
					@resultado = "OK"
					#break NO FUNCIONA 
				end
			end
  		end
	end
    if !(@resultado == expecting)
    	
    	raise('Fallo')
  	end
end