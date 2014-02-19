# =  Listar artefactos proyectos

####################################################################################################
# TODO:
# DADO EL NOMBRE DEL PROYECTO CONSEGUIR SU ID DE FOLDER EN RAZUNA
####################################################################################################

Dado /^que en listar artefactos proyectos un usuario se encuentra en la ventana de (.*)$/ do | pagina |

  @proyecto = Proyecto.new(
  :nombre => 'Proyecto Test',
  :descripcion => "Esta es una descripcion")
  @proyecto.save

  visit pagina
end

Cuando /^en listar artefactos proyectos ha creado el artefacto (.*)$/ do | artefacto |

  @artefacto = Artefacto.new(
  :nombre => artefacto)
  @artefacto.save
  
 	# Consultamos folder con el nombre
	url = 'http://pruebasdavid.virtual.uniandes.edu.co:8080/razuna/global/api2/folder.cfc'
	method = '?method=getfolders'
	apikey = '&api_key=8F852FE7C05B44528D696CA9A08125AA&__BDRETURNFORMAT=wddx'
 	
      #@wddx = WDDX.load(open(url))

	uri = URI(url + method + apikey + folder)
	puts url + method + apikey + folder	
	@response = Net::HTTP.get_response(uri) # Invocamos.
	
      @folders_found = @wddx.data.fields
      _folder_id = "0"
      _i = 0
      until _i >= @folders_found.count()  do

        _folder = @folders_found[_i]
        if(_folder[_i] == 'Animaciones')
          _folder_id = _folder[_i]
        end
        _i += 1
      end
	
 	
	url = 'http://pruebasdavid.virtual.uniandes.edu.co:8080/razuna/global/api2/folder.cfc'
	method = '?method=getassets'
	apikey = '&api_key=8F852FE7C05B44528D696CA9A08125AA'
	folder = '&folderid=2B9600F69DA44D0292B1BCEF481239DC'
	uri = URI(url + method + apikey + folder)

	puts url + method + apikey + folder
	
	@response = Net::HTTP.get_response(uri) # Invocamos.
	@resultado = 'OK'
	listo = @response.body[@artefacto.nombre]
	if listo == nil

		@resultado = 'KO'
	end
end

Entonces /^en listar artefactos proyectos se espera ver el resultado (.*)$/ do | resultado_feature |

	if !(@resultado == resultado_feature)
	
		raise('Fallo')
	end
end
