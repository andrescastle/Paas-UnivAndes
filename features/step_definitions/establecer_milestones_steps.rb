# =  HU_TP_Establecer milestones

Dado /^que en milestones tengo la actividad (.*)$/ do | actividad |

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

    @actividad = Actividad.new(
      :nombre => actividad,
      :descripcion => "Descripcion 1",
      :modoejecucion => 1,
      :plantilla_id => 1,
	  :duracion => 1,
	  :my_js_tree_id => @my_js_tree.id)
end

Cuando /^marco la opcion hito/ do

  @resultado = "OK"
  if @resultado == "OK"
    if (@actividad.save())
      @resultado = "OK"
    else
      @resultado = "KO"
    end
  end
end

Entonces /^en milestones se espera ver el resultado (.*)$/ do | resultado |

  if (@resultado != resultado)
  	raise("Fallo")
  end
end
