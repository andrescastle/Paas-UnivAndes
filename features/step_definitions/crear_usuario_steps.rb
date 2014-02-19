# =  Crear un usuario
# Aqui se implementan los pasos especificos de los escenarios de prueba de la historia de usuario

####################################################################################################
# TODO:
# PROBAR CREAR CON CAMPOS ROL, IMAGEN
####################################################################################################
# Asignacion de nombre
Dado /^que he introducido un usuario con nombre (.*)$/ do |nombre|
  @nombre = nombre
end

Y /^login (.*)/ do |login|
  @login = login
end

Y /^password (.*)/ do |password|
  @password = password
end

# Persistencia del usuario
Cuando /^se guarde el usuario$/ do

	@usuario = Usuario.new(
	:nombre => "juan",
	:login => "juan",
	:password => "juan")
	@usuario.save

	@usuarios = Usuario.all
    @resultado = "OK"
    @usuarios.each do | usuariotmp |
    
    	#if @resultado == "OK"
    	
			if usuariotmp.login == @login
				
				@resultado = "KO"
			end
  		#end
	end

	if @resultado == "OK"

		@usuario = Usuario.new(
		:nombre => @nombre,
		:login => @login,
		:password => @password)
	
		if !(@usuario.save)
		
			@resultado = "KO"
		else

			url = 'http://pruebasdavid.virtual.uniandes.edu.co:8080/razuna/global/api2/folder.cfc'
			method = '?method=add'
			apikey = '&api_key=8F852FE7C05B44528D696CA9A08125AA'
			user_first_name = '&user_first_name=Juan'
			user_last_name = '&user_last_name=Moreno'
			user_email = '&user_email=jm.moreno743@uniandes.edu.co'
			user_name = '&user_name=jm.moreno743'
			user_pass = '&user_pass=123456'			
			uri = URI(url + method + apikey + user_first_name + user_last_name + user_email + user_name + user_pass)
			puts url + method + apikey + user_first_name + user_last_name + user_email + user_name + user_pass
			#@response = Net::HTTP.get_response(uri) # Invocamos.
			#@resultado = 'OK'
			#listo = @response.body[apikey]
			#if listo == nil
		
				#@resultado = 'KO'
			#end
		end
	end
end

Entonces /^el resultado debe ser (.*)/ do | expecting |

    if !(@resultado == expecting)
    	
    	raise('Fallo')
  	end
end
