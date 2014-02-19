# =  HU_TP_Crear una compuerta
# Crear compuerta

Dado /^que en crear una compuerta creo una compuerta con nombre (.*) descripcion (.*) tipo de compuerta (.*) y tipo de decision (.*)/ do | nombre, descripcion, tipo_compuerta, tipo_decision |

  @compuerta = Compuertu.new(
    :nombre => nombre,
    :descripcion => descripcion,
    :plantilla_id => 1,
    :tipo => tipo_compuerta,
    :desicion => tipo_decision )
end

Cuando /^en crear una compuerta se guarde la compuerta$/ do

  if (@compuerta.save())
  	@resultado = "OK"
  else
  	@resultado = "KO"
  end
end

Entonces /^en crear una compuerta se espera ver (.*?)$/ do | resultado |

  if (@resultado != resultado)
  	raise("Fallo")
  end
end
