# =  Crear un usuario
# Aqui se implementan los pasos especificos de los escenarios de prueba de la historia de usuario

#Visualizar una tabla o lista
Dado /^que en usuarios un usuario se encuentra en la ventana de (.*)$/ do | pagina |
  visit pagina
end

Cuando /^en listar usuarios aplica la opcion (.*)$/ do | opcion |
  click_link(opcion)
end

Entonces /^en listar usuarios se espera ver una tabla que tiene una columna (.*)$/ do | columna |
  page.should have_content( columna )
end

Y /^con una opcion en listar usuarios (.*)$/ do | opcion |
  page.should have_content( opcion )
end

# Simula la creacion de un usuario para visualización
####################################################################################################
# TODO:
# PROBAR LOS CAMPOS ROL E IMAGEN
####################################################################################################

Dado /^que en listar usuarios un usuario se encuentra en la ventana de (.*)$/ do | pagina |
  visit pagina
end

Cuando /^crea un usuario con nombre (.*)$/ do | nombre |
  @nombre = nombre
end

Y /^en listar usuarios doy login (.*)/ do |login|
  @login = login
end

Y /^guardo el usuario$/ do
  @usuario = Usuario.new(
  :nombre => @nombre,
  :login => @login)
  @usuario.save
end

Y /^crea otro usuario con nombre (.*)$/ do | nombre |
  @nombre = nombre
end

Y /^en listar usuarios al regresar a la ventana (.*)$/ do | pagina |
  visit pagina
end

Entonces /^en listar usuarios se espera ver una lista con el valor (.*)$/ do | nombre |
  page.should have_content( nombre )
end

Y /^el valor en listar usuarios (.*)$/ do | nombre |
  page.should have_content( nombre )
end