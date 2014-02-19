# = listar_tipo_plantillas_steps.rb
#
# Juan Manuel Moreno B.
# Universidad de Los Andes
#
# == Acerca de
#
# Este artefacto se caracteriza por:
# - Contiene los pasos requeridos por listar_tipo_plantillas.feature*
# - No debe ser igual a los pasos de los demas steps
#
# === Descripcion pasos
#
# Dado que en tipos de plantillas he introducido un tipo de plantilla nuevo
#
# Entonces se espera en tipos de plantillas ver el resultado en la pagina /tipo_plantillas

#Escenario mostrar una lista de tipos de plantillas visitando la pagina
Dado /^que en tipos de plantillas estoy en la pagina (.*)$/ do | pagina |
  visit pagina
end

Y /^en tipos de plantillas he introducido (.*) con descripcion (.*)$/ do | tipo_plantilla_1, descripcion |
  #@tipoPlantilla = TipoPlantilla.find_by_nombre ("tipo 1")

  @tipoPlantilla = TipoPlantilla.create(
    :nombre => tipo_plantilla_1,
    :descripcion => descripcion)
end

Entonces /^se espera en tipos de plantillas ver (.*)$/ do | resultado1 |
  page.should have_content( resultado1 )
end

#Escenario mostrar una lista de recursos desde menu desde otra pagina
Dado /^que en tipos de plantillas desde menu antes he introducido (.*) con descripcion (.*)$/ do | tipo_plantilla_1,  descripcion |
  #@tipoPlantilla = TipoPlantilla.find_by_nombre ("tipo 1")

  @tipoPlantilla = TipoPlantilla.create(
    :nombre => tipo_plantilla_1,
    :descripcion => descripcion)
end

Y /^en tipos de plantillas desde menu estoy en la pagina (.*)$/ do | pagina |
  visit pagina
end

Y /^en tipos de plantillas desde menu uso la opcion de ver tipos de plantillas$/ do
  click_on('Tipos de plantillas')
end

Entonces /^se espera en tipos de plantillas desde menu ver (.*)$/ do | resultado1 |
  page.should have_content( resultado1 )
end

