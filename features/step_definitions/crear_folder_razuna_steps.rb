# language: es
# =  Ver tareas asignadas

####################################################################################################
# TODO:
####################################################################################################

# Ver tareas de un usuario
Dado /^que en crear folder soy el usuario (.*)$/ do |nombre|

	@apikey = '8F852FE7C05B44528D696CA9A08125AA' # API key del usuario razuna requerida para invocar metodos desde una URL
end

Cuando /^en crear folder creo el folder (.*)$/ do |folder|
	
	# Consultamos folder con el nombre
	url = 'http://pruebasdavid.virtual.uniandes.edu.co:8080/razuna/global/api2/folder.cfc'
		method = '?method=getfolders'
			api = '&api_key=' + @apikey
				uri = URI(url + method + api)
	@response = Net::HTTP.get_response(uri) # Invocamos.
	@resultado = 'OK'
	listo = @response.body[folder]
	if !(listo == nil)

		@resultado = 'KO'
	else

		# Creamos el folder
		method = '?method=setfolder'
			name = '&folder_name=' + folder
				uri = URI(url + method + api + name)
		@response = Net::HTTP.get_response(uri)  # Invocamos.
	end
end

Entonces /^en crear folder se espera el resultado (.*)$/ do |resultado_feature|
	
	if !(@resultado == resultado_feature)
	
		raise('Fallo')
	end
end
