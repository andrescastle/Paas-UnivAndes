# =  Crear un tipo de artefacto
# Aqui se implementan los pasos especificos de los escenarios de prueba de la historia de usuario

# Asignacion de nombre
Dado /^que he introducido un tipo de artefacto con nombre (.*)$/ do |nombre|
  @nombre = nombre
end

Y /^descripcion (.*)/ do |descripcion|
  @descripcion = descripcion
end

# Persistencia del tipo de artefacto
Cuando /^se guarde el tipo de artefacto$/ do
  @tipoArtefacto = TipoArtefacto.new(
  :nombre => @nombre,
  :descripcion => @descripcion)

  if(@tipoArtefacto.save)
    @resultado = "OK"
  else
    @resultado = "KO"
  end
end
