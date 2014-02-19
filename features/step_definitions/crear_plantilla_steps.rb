# =  HU_TP_Crear Plantilla de proceso
# Crear tipo de plantilla
Dado /^que en plantillas creo una plantilla con nombre (.*) descripcion (.*) imagen de icono (.*) tipo de plantilla (.*)$/ do | nombre, descripcion, imagen, tipo |

  # Validamos imagen.
  type = imagen.split(".")[1]
  if type == "jpg" || type == "bmp" || type == "png"
    @resultado = "OK"
  else
    @resultado = "KO"
  end

  if (@resultado == 'OK')
    @plantilla = Plantilla.new(
      :nombre => nombre,
      :descripcion => descripcion,
      :tipo_plantilla_id => tipo )
  end
#  @myimagen = Image.new(
#    :image_file_name => imagen)
  #stub_paperclip_s3('image', 'imas_logo_large', 'jpg')
  #attach_file 'plantilla_imagen', 'C:/imas_logo_large.jpg'
end

Cuando /^en plantillas se guarde la plantilla/ do

  if (@resultado == 'OK')
    if (@plantilla.save())
      @resultado = "OK"
    else
      @resultado = "KO"
    end
  end
end

Entonces /^en plantillas se espera ver (.*?)$/ do | resultado |

  if (@resultado != resultado)
  	raise("Fallo")
  end
end
