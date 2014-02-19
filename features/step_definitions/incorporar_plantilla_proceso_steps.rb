# = Incorporar Plantilla  Proceso
Dado /^que en incorporar creo un proceso con nombre (.*) y una actividad (.*)$/ do | proceso_nombre, actividad_nombre |

	@my_js_tree = MyJsTree.new(
		:parent_id => 1,
		:position => 1,
		:left => 1,
		:right => 1,
		:title => "este es mi arbol de pruebas",
		:type => 1,
		:level => 1,
		:proceso_id => 1)
	@my_js_tree.save!
	
    @proceso = Proceso.new(
      :nombre => proceso_nombre,
      :tipo_plantilla_id => 1 )
    @proceso.save!
    
	@actividad = Actividad.new(
	  :nombre => actividad_nombre,
	  :descripcion => actividad_nombre,
	  :modoejecucion => 1,
	  :duracion => 1,
	  :proceso_id => @proceso.id,
	  :my_js_tree_id => @my_js_tree.id)
	@actividad.save!
end

Cuando /^en incorporar asocie la actividad/ do

	@actividad_proceso = Actividad.new(
	  :nombre => @actividad.nombre,
	  :descripcion => @actividad.descripcion,
	  :modoejecucion => @actividad.modoejecucion,
	  :duracion => @actividad.duracion,
	  :proceso_id => @actividad.proceso_id,
	  :my_js_tree_id => @actividad.my_js_tree.id)

    if (@actividad_proceso.save())
      @resultado = "OK"
    else
      @resultado = "KO"
    end
end

Entonces /^en incorporar se espera ver (.*?)$/ do | resultado |

  if (@resultado != resultado)
  	raise("Fallo")
  end
end
