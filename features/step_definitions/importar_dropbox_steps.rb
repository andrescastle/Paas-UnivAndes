# language: es
# = Importar artefactos Dropbox
####################################################################################################
# TODO:
# PROBAR CON VARIABLES DE ENTORNO
# PASAR ARTEFACTOS COMO PARAMETROS
####################################################################################################
require 'dropbox_sdk'

# Importar artefactos Dropbox
Dado /^que en importar desde Dropbox soy el usuario (.*)$/ do |nombre|

	@login = nombre
end

Y /^en importar desde Dropbox tengo clave (.*)$/ do |clave|

	@clave = clave
end

Cuando /^en importar desde Dropbox importo artefactos/ do

    @deposito = Deposito.new(
    	:cuenta => 'NULL',
    	:usuario => 'leidy',
    	:contrasena => '',
    	:nombre => 'Nuevo')
    @deposito.save;

  APP_KEY = 'u3ufaps11mkjwbk'
  APP_SECRET = 'qxyo5b3xqrio7lc'

# CREAMOS NUEVO TOKEN
      dbsession = DropboxSession.new(APP_KEY, APP_SECRET)
      File.open("dropbox_session.txt", 'wb') { |file| file.write(dbsession.serialize) }
      #dbsession.set_access_token(APP_KEY, APP_SECRET)
#dbsession.get_request_token
      #dbsession.set_request_token(dbsession.get_request_token.key, dbsession.get_request_token.secret)

      #session[:dropbox_session] = dbsession.serialize #serialize and save this DropboxSession
      #session[:dropbox_nombre] = params[:deposito_nombre]
      #session[:dropbox_descripcion] = params[:deposito_descripcion]

  ACCESS_TYPE = :dropbox
  #dbsession = DropboxSession.new(APP_KEY, APP_SECRET)    
  #dbsession.get_request_token

# AUTORIZAMOS DANDO 30' PARA PERMITIR LO QUE DESEAMOS A LA APLICACION
  authorize_url = dbsession.get_authorize_url()  
  STDOUT.puts authorize_url
  sleep(20)

# PERSISTIMOS
      #dbsession.set_access_token(APP_KEY, APP_SECRET) 
      #File.open("dropbox_session.txt", 'wb') { |file| file.write(dbsession.serialize) }
      #File.open("dropbox_nombre.txt", 'w')  { |file| file.write(params[:deposito_nombre]) }
      #File.open("dropbox_descripcion.txt", 'w')  { |file| file.write(params[:deposito_descripcion]) }

# VERIFICAMOS QUE CREAMOS UNA SESION DADA LA PERSISTENCIA A ARCIHVO REALIZADA
      file = File.open("dropbox_session.txt", "rb")
      dbsessioni = DropboxSession.deserialize(file.read)
  dbsessioni.get_access_token
  File.open("dropbox_session.txt", 'wb') { |file| file.write(dbsessioni.serialize) }
  file = File.open("dropbox_session.txt", "rb")
  dbsessionj = DropboxSession.deserialize(file.read)  
#dbsessionj.set_access_token(APP_KEY, APP_SECRET)  
  STDOUT.puts dbsessionj.authorized?.to_s

  client = DropboxClient.new(dbsessionj, ACCESS_TYPE)
  path = '/'
  file_metadata = client.metadata(path)

# HACEMOS EJERCICIO ARCHIVO
file=Hash.new
file["name"] = "hola.jpg"
file["url"]="images/icon_image.jpg"
@files=Array.new
@files.push(file)
file["name"] = "marce.jpg"
file["url"]="images/icon_image.jpg"
@files.push(file)
STDOUT.puts @files
File.open("dropbox_files.txt", 'wt') { |file| file.write(@files) }
written = File.open("dropbox_files.txt", "rt")
STDOUT.puts written.read

#  puts "metadata:", file_metadata.inspect
  @resultado = 'OK'
end

Entonces /^en importar desde Dropbox se espera el resultado (.*)$/ do |resultado_feature|
	
	if !(@resultado == resultado_feature)
	
		raise('Fallo')
	end
end

