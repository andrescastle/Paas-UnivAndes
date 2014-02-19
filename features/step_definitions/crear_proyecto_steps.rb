# =  Crear un proyecto
# Aqui se implementan los pasos especificos de los escenarios de prueba de la historia de usuario

####################################################################################################
# TODO:
# PROBAR CREAR CON CAMPOS TIPO, IMAGEN
####################################################################################################
# Asignacion de nombre
Dado /^que he introducido un proyecto con nombre (.*)$/ do |nombre|
  @nombre = nombre
end

Y /^para el proyecto he agregado descripcion (.*)/ do |descripcion|
  @descripcion = descripcion
end

# Persistencia del proyecto
Cuando /^se guarde el proyecto$/ do
  @proyecto = Proyecto.new(
  :nombre => @nombre,
  :descripcion => @descripcion)

  if(@proyecto.save)
    @resultado = "OK"
  else
    @resultado = "KO"
  end
end
