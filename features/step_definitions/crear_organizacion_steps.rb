# =  Crear una organizacion
# Aqui se implementan los pasos especificos de los escenarios de prueba de la historia de usuario

####################################################################################################
# TODO:
####################################################################################################
# Asignacion de nombre
Dado /^que he introducido una organizacion con nombre (.*)$/ do | nombre |
  @nombre = nombre
end

Y /^es una organizacion con direccion (.*)/ do | direccion |
  @direccion = direccion
end

Y /^es una organizacion con nit (.*)/ do | nit |
  @nit = nit
end

# Persistencia de la organizacion
Cuando /^se guarde la organizacion$/ do

	@organizacion = Organizacion.new(
	:nombre => "Casa Spencer",
	:direccion => "arrayanes@yo.com",
	:nit => "1234567")
	@organizacion.save

	@organizaciones = Organizacion.all
    @resultado = "OK"
    @organizaciones.each do | organizaciontmp |
    
    	#if @resultado == "OK"
    	
			if organizaciontmp.nit == @nit
				
				@resultado = "KO"
			end
  		#end
	end

	if @resultado == "OK"

		@organizacion = Organizacion.new(
		:nombre => @nombre,
		:direccion => @direccion,
		:nit => @nit)
	
		if !(@organizacion.save)
		
			@resultado = "KO"
		end
	end
end

Entonces /^el resultado debe ser (.*)/ do | expecting |

    if !(@resultado == expecting)
    	
    	raise('Fallo')
  	end
end
