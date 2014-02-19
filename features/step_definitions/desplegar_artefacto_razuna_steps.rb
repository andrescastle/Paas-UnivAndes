# language: es
# =  Ver tareas asignadas

####################################################################################################
# TODO:
####################################################################################################

# Ver tareas de un usuario
Dado /^que en desplegar artefactos soy el usuario (.*)$/ do |nombre|

	@apikey = '8F852FE7C05B44528D696CA9A08125AA' # API key del usuario razuna requerida para invocar metodos desde una URL
end

Cuando /^en desplegar artefactos consulto el artefacto (.*)$/ do |artefacto|
	
	# Consultamos folder con el nombre
	url = 'http://pruebasdavid.virtual.uniandes.edu.co:8080/razuna/global/api2/folder.cfc'
		method = '?method=searchassets'
			api = '&api_key=' + @apikey
				name = '&searchfor=' + artefacto
	uri = URI(url + method + api)
	@response = Net::HTTP.get_response(uri) # Invocamos.
	@resultado = 'OK'
	listo = @response.body[artefacto]
	if listo == nil

		@resultado = 'KO'
	end
end

Entonces /^en desplegar artefactos se espera el resultado (.*)$/ do |resultado_feature|
	
	if !(@resultado == resultado_feature)
	
		raise('Fallo')
	end
end
