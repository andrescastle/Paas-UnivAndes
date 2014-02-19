# Simula la creacion de un tipo de recurso para visualización
Cuando /^crea un tipo de recurso con nombre: (.*)$/ do |nombre|
    @tipoRecurso = TipoRecurso.new(
      :nombre => nombre)

      if(!@tipoRecurso.save)
        raise "Fallo!"
      end
end

# Simula la seleccion de un tipo de recurso en la grilla
Dado /^que selecciona un tipo de recurso con el nombre: (.*)$/ do |nombre|
  @tipoRecurso = TipoRecurso.find_by_nombre(nombre)
end

# Simula la edicion de un tipo de recurso en la grilla
Cuando /^modifica del tipo de recurso su nombre: (.*)$/ do |nombre|

  @tipoRecurso.nombre = nombre

  if(!@tipoRecurso.save())
    raise "fallo"
  end
end

# Simula la eliminacion de un tipo de recurso en la grilla
Dado /^confirma la operacion de eliminar el tipo de recurso$/ do
  if(!@tipoRecurso.delete())
    raise "Fallo!"
  end
end