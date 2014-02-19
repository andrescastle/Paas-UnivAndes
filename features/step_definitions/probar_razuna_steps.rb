# language: es
# =  Ver tareas asignadas

####################################################################################################
# TODO:
####################################################################################################

# Ver tareas de un usuario
Dado /^que soy el usuario (.*)$/ do |nombre|
#pending
end

Cuando /^visito la pagina (.*)$/ do |pagina|
  url = pagina


  payload = {
"method" => "getfolder",
"api_key" => "8F852FE7C05B44528D696CA9A08125AA",
"folderid" => "067A56D20F264918AA66D729C46652D8"
      }.to_json
 
#url = pagina + '?#{payload}'
url = pagina
#    uri = URI.parse(URI::escape(url))
#    http = Net::HTTP.new(uri.host,uri.port)
#    headers={'content-type'=>'applications/json'}
#    @response, @body = http.get_response(uri.request_uri)
uri = URI(pagina)
@response = Net::HTTP.get_response(uri)

end

Entonces /^se espera una respuesta/ do
	p @response #will return httpok status
	p @response.body
  	#p JSON.parse(@body) #will return a hash table which you can parse
end
