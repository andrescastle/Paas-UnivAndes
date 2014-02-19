# =  Instanciar Actividad en Proceso

Dado /^que en instanciar una actividad creo una actividad con nombre (.*) descripcion (.*) imagen de icono (.*) modo de ejecucion (.*)$/ do | nombre, descripcion, imagen, modo |

	# Creamos arbol
	@my_js_tree = MyJsTree.new(
		:parent_id => 1,
		:position => 1,
		:left => 1,
		:right => 1,
		:title => "este es mi arbol de pruebas",
		:type => 1,
		:level => 1)
	@my_js_tree.save!

	# Creamos proceso
    @proceso = Proceso.new(
      :nombre => "este es mi proceso de pruebas",
      :tipo_plantilla_id => 1 )
    @proceso.save!
    
  # Validamos imagen.
  type = imagen.split(".")[1]
  if type == "jpg" || type == "bmp" || type == "png"
    @resultado = "OK"
  else
    @resultado = "KO"
  end

  if (@resultado == 'OK')
    @actividad = Actividad.new(
      :nombre => nombre,
      :descripcion => descripcion,
      :modoejecucion => modo,
      :plantilla_id => 1,
	  :duracion => 1,
	  :proceso_id => @proceso.id,
	  :my_js_tree_id => @my_js_tree.id)
	end
end

Cuando /^en instanciar una actividad se guarde la actividad$/ do

  if @resultado == "OK"
    if (@actividad.save())
      @resultado = "OK"
    else
      @resultado = "KO"
    end
  end
end

Entonces /^en instanciar una actividad se espera ver (.+)$/ do | resultado |

  if (@resultado != resultado)
  	raise("Fallo")
  end
end
