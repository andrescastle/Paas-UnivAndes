# =  Crear un proyecto
# Aqui se implementan los pasos especificos de los escenarios de prueba de la historia de usuario

#Visualizar una tabla o lista
Dado /^que un usuario se encuentra en la ventana de (.*)$/ do | pagina |
  visit pagina
end

Cuando /^en listar proyectos aplica la opcion (.*)$/ do | opcion |
  click_link(opcion)
end

Entonces /^en listar proyectos se espera ver una tabla que tiene una columna (.*)$/ do | columna |
  page.should have_content( columna )
end

Y /^con una opcion en listar proyectos (.*)$/ do | opcion |
  page.should have_content( opcion )
end

# Simula la creacion de un proyecto para visualización

####################################################################################################
# TODO:
# PROBAR LOS CAMPOS TIPO, DESCRIPCION, IMAGEN
####################################################################################################
Dado /^que en proyectos un usuario se encuentra en la ventana de (.*)$/ do | pagina |
  visit pagina
end

Cuando /^crea un proyecto con nombre (.*)$/ do |nombre|
  @proyecto = Proyecto.new(
  :nombre => @nombre,
  :descripcion => "Esta es una descripcion")
  @proyecto.save
end

Y /^en listar proyectos al regresar a la ventana (.*)$/ do | pagina |
  visit pagina
end

Entonces /^en listar proyectos se espera ver una lista con el valor (.*)$/ do | nombre |
  pending #page.should have_content( nombre )
end

Y /^el valor en listar proyectos (.*)$/ do | nombre |
  page.should have_content( nombre )
end