# =  HU_CR_Crear un tipo de Recurso (sto380)
# Aqui se implemntan los pasos especificos de los escenarios de prueba de la historia de usuario

# Asignacion de nombre
Dado /^que he introducido un tipo de recurso con nombre (.*)$/ do |nombre|
  @nombre = nombre
end

Y /^costo (.*)/ do |costo|
  @costo = costo
end

Y /^unidades (.*)/ do |unidades|
  @unidades = unidades
end

# Persistencia del tipo de recurso
Cuando /^se guarde el tipo de recurso$/ do
  @tipoRecurso = TipoRecurso.new(
  :nombre => @nombre,
  :cost => @costo,
  :unit => @unidades)

  if(@tipoRecurso.save)
    @resultado = "OK"
  else
    @resultado = "Error"
  end
  
end

# Presentacion del resultado
Entonces /^el resultado debe ser: (.*)$/ do |resultado|
  if(@resultado != resultado)
    raise("Fallo")
  end
end



