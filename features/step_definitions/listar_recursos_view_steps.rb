# = listar_recursos_steps.rb
#
# Juan Manuel Moreno B.
# Universidad de Los Andes
#
# == Acerca de
#
# Este artefacto se caracteriza por:
# - Contiene los pasos requeridos por listar_recurso.feature*
# - No debe ser igual a los pasos de los demas steps
#
# === Descripcion pasos
#
# Dado que en recursos he introducido un objeto recurso nuevo
#
# Entonces se espera en recursos ver el resultado en la pagina /recursos

# Al abrir la pagina segun la ruta enviada
Dado /^que en recursos estoy en la pagina (.*)$/ do | pagina |
  visit pagina
end

Y /^en recursos he introducido (.*)$/ do | recurso_1 |
  @tipoRecurso = TipoRecurso.find_by_nombre ("Licencia")

  @recurso1 = Recurso.create(
    :nombre => recurso_1,
    :tipo_recurso_id => @tipoRecurso.id,
    :organizacion_id => 1,
    :costo => 20,
    :unidades => 1,
    :descripcion => "una descripcion")

end

Y /^en recursos vuelvo a (.*)$/ do |  pagina |
 visit pagina
end

Entonces /^se espera en recursos ver (.*)$/ do | resultado1 |
  page.should have_content( resultado1 )
#  page.should have_content( resultado2 )
end


Dado /^que en recursos desde menu antes he introducido (.*)$/ do | recurso_1 |
  @tipoRecurso = TipoRecurso.find_by_nombre ("Licencia")

  @recurso1 = Recurso.create(
    :nombre => recurso_1,
    :tipo_recurso_id => @tipoRecurso.id,
    :organizacion_id => 1,
    :costo => 20,
    :unidades => 1,
    :descripcion => "una descripcion")
end

Dado /^que en recursos desde menu estoy en la pagina (.*)$/ do | pagina |
  visit pagina
end


Dado /^en recursos desde menu uso la opcion de recursos$/ do
  click_on('Recursos')
end

Entonces /^se espera en recursos desde menu ver (.*)$/ do | resultado1 |
  page.should have_content( resultado1 )
#  page.should have_content( resultado2 )
end

