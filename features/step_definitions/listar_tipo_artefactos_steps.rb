# =  Crear un tipo de artefacto
# Aqui se implementan los pasos especificos de los escenarios de prueba de la historia de usuario

#Visualizar una tabla o lista
Dado /^que en tipos de artefactos un usuario se encuentra en la ventana de (.*)$/ do |pagina|
  visit pagina
end

Cuando /^en listar tipos de artefactos aplica la opcion (.*)$/ do | opcion |
  click_link(opcion)
end

Entonces /^en listar tipos de artefactos se espera ver una tabla que tiene una columna (.*)$/ do | columna |
  page.should have_content( columna )
end

Y /^con una opcion en listar tipos de artefactos (.*)$/ do | opcion |
  page.should have_content( opcion )
end

# Simula la creacion de un tipo de artefacto para visualización
Dado /^que en listar tipos de artefactos un usuario se encuentra en la ventana de (.*)$/ do | pagina |
  visit pagina
end

Cuando /^crea un tipo de artefacto con nombre (.*)$/ do |nombre|
	@tipoArtefacto1 = TipoArtefacto.new(
	:nombre => @nombre,
	:descripcion => "este es un tipo de artefacto")
end

Y /^crea otro tipo de artefacto con nombre (.*)$/ do |nombre|
	@tipoArtefacto2 = TipoArtefacto.new(
	:nombre => @nombre,
	:descripcion => "este es otro tipo de artefacto")
end

Y /^en listar tipos de artefactos al regresar a la ventana (.*)$/ do | pagina |
  visit pagina
end

Entonces /^en listar tipos de artefactos se espera ver una lista con el valor  (.*)$/ do | nombre |
  page.should have_content( nombre )
end

Y /^el valor en listar tipos de artefactos (.*)$/ do | nombre |
  pending #page.should have_content( nombre )
end