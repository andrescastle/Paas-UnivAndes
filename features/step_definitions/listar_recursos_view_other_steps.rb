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
Dado /^que en recursos desde otra vista antes he introducido (.*)$/ do | recurso_1 |
  @recurso1 = Recurso.create(
    :nombre => recurso_1,
    :tipo_recurso_id => "un tipo",
    :costo => 20,
    :unidades => 1,
    :descripcion => "una descripcion")
end

Y /^en recursos desde otra vista estoy en la vista (.*)$/ do | pagina |
  visit pagina
end


Y /^en recursos desde otra vista introduzco la vista (.*)$/ do | pagina_recursos |
  visit pagina_recursos
end

Entonces /^se espera en recursos desde otra vista ver (.*)$/ do | resultado1 |
  page.should have_content( resultado1 )
#  page.should have_content( resultado2 )
end


