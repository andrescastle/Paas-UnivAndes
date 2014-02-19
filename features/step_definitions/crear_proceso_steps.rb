# =  HU_TP_Crear Plantilla de proceso
# Crear tipo de plantilla
Dado /^que en procesos creo un proceso con nombre (.*) tipo de plantilla (.*)$/ do | nombre, tipo |

    @proceso = Proceso.new(
      :nombre => nombre,
      :tipo_plantilla_id => tipo )
#  @myimagen = Image.new(
#    :image_file_name => imagen)
  #stub_paperclip_s3('image', 'imas_logo_large', 'jpg')
  #attach_file 'plantilla_imagen', 'C:/imas_logo_large.jpg'
end

Cuando /^en procesos se guarde el proceso/ do

    if (@proceso.save())
      @resultado = "OK"
    else
      @resultado = "KO"
    end
end

Entonces /^en procesos se espera ver (.*?)$/ do | resultado |

  if (@resultado != resultado)
  	raise("Fallo")
  end
end
