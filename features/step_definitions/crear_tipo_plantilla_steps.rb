# =  HU_TP_Crear un Tipo de Plantilla
# Crear tipo de plantilla
Dado /^que en tipos de plantillas creo un tipo de plantilla con nombre (.*) y descripcion (.*)$/ do | nombre, descripcion |

  @tipoplantilla = TipoPlantilla.new(
	:nombre => nombre,
	:descripcion => descripcion )  
end

Cuando /^en tipos de plantillas se guarde el tipo de plantilla$/ do

  if (@tipoplantilla.save())
  	@resultado = "OK"
  else
  	@resultado = "KO"
  end
end

Entonces /^en tipos de plantillas se espera ver (.*?)$/ do | resultado |

  if (@resultado != resultado)
  	raise("Fallo")
  end
end
