# language: es
# =  Ver tareas asignadas

####################################################################################################
# TODO:
# MEJORAR LA FORMA DE ADQUIRIR EL SESSION TOKEN
####################################################################################################

# Ver tareas de un usuario
Dado /^que en autenticarme en razuna soy el usuario (.*)$/ do |nombre|

	@login = nombre
end

Y /^en autenticarme en razuna tengo clave (.*)$/ do |clave|

	@clave = clave
end

Cuando /^en autenticarme en razuna entro/ do
	
	# Consultamos folder con el nombre
	url = 'http://pruebasdavid.virtual.uniandes.edu.co:8080/razuna/global/api/authentication.cfc?hostid=1'
	method = '&method=login'
	user = '&user=' + @login
	pass = '&pass=' + @clave
	passhashed = '&passhashed=0'
	uri = URI(url + method + user + pass + passhashed)

	# FORMA DE ADQUIRIR EL SESSION TOKEN TODO: MEJORARLO
	tutti = open(url + method + user + pass + passhashed).read
	after = tutti.split('sessiontoken&gt;', 2).last
	token = after.split('&lt;/sessiontoken&gt', 2).first
	puts token + ";"
	
	@resultado = 'OK'
	if token == 'Access Denied'

		@resultado = 'KO'
	else

	end
end

Entonces /^en autenticarme en razuna se espera el resultado (.*)$/ do |resultado_feature|
	
	if !(@resultado == resultado_feature)
	
		raise('Fallo')
	end
end

