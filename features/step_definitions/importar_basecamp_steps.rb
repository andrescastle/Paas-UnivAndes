# language: es
# = Importar artefactos Basecamp
####################################################################################################
# TODO:
# PROBAR CON VARIABLES DE ENTORNO
# PASAR ARTEFACTOS COMO PARAMETROS
####################################################################################################

# Importar artefactos Basecamp
Dado /^que en importar desde Basecamp soy el usuario (.*)$/ do |nombre|

	@login = nombre
end

Y /^en importar desde Basecamp tengo clave (.*)$/ do |clave|

	@clave = clave
end

Cuando /^en importar desde Basecamp importo artefactos/ do

    @deposito = Deposito.new(
    	:cuenta => 'https://basecamp.com/2267341',
    	:usuario => 'projectrevista@gmail.com',
    	:contrasena => 'r0s6l3sd',
    	:nombre => 'BasecampLeidy')
    @deposito.save;

    @basecamp = Basecamp.establish_connection!(@deposito.cuenta, @deposito.usuario, @deposito.contrasena, false)
    @projects = Array.new
    @c= 'json'

    begin
      @data_for_select = Basecamp::Project.find(:all)

      @tam=@data_for_select.length
      @i=1
      @data = @c+"({"+"\""
      @data_for_select.each do |select|
        @data  = @data+select.id.to_s+"\""+":"+"\""+select.name+"\""
        if @tam!=@i
          @data=@data+","+"\""
        else
          @data=@data+"})"
        end
        @i=@i+1
      end

    rescue
      url = @deposito.cuenta+'/api/v1/projects.json'
      uri = URI.parse(url)

      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req = Net::HTTP::Get::new(uri.path)
      req.basic_auth @deposito.usuario, @deposito.contrasena

      resp = http.request(req)
      @data_for_select = JSON.parse!(resp.body)

      @tam=@data_for_select.length
      @i=1
      @data = @c+"({"+"\""
      @data_for_select.each do |select|
        @data  = @data+select["id"].to_s+"\""+":"+"\""+select["name"]+"\""
        if @tam!=@i
          @data=@data+","+"\""
        else
          @data=@data+"})"
        end
        @i=@i+1
      end

    end

	puts @data
    
    @resultado = 'OK'
end

Entonces /^en importar desde Basecamp se espera el resultado (.*)$/ do |resultado_feature|
	
	if !(@resultado == resultado_feature)
	
		raise('Fallo')
	end
end

