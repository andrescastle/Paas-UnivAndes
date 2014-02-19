# =  HU_CR_Listar recurso (sto516)
# Aqui se implemntan los pasos especificos de los escenarios de prueba de la historia de usuario

# Mantenida por semantica
Cuando /^un usuario presiona la opcion crear un recurso$/ do

end

# Simula la creacion de un recurso para visualización
Y /^crea un recurso con nombre: (.*) tipo: (.*) costo: (\d+) unidades: (\d+)$/ do |nombre, tipo, costo, unidades|
    @tipoRecurso = TipoRecurso.find_by_nombre (tipo)

    @recurso = Recurso.new(
      :nombre => nombre,
      :tipo_recurso_id => @tipoRecurso.id,
      :costo => costo,
      :unidades => unidades,
      :descripcion => "" )

      @recurso.organizacion_id = 1

      if(!@recurso.save)
        raise "Fallo!"
      end
end

# Simula la seleccion de un recurso en la grilla
Dado /^que selecciona un recurso con el nombre: (.*)$/ do |nombre|
  @recurso = Recurso.find_by_nombre(nombre)
end

# Simula la eliminacion de un recurso desde la grilla
Dado /^confirma la operacion de eliminar el recurso$/ do
  if(!@recurso.delete())
    raise "Fallo!"
  end
end

# Simula la edicioón de un recurso desde la grilla
Cuando /^modifica del recurso su nombre: ([^"]*), tipo: ([^"]*), costo: (\d+), unidades: (\d+)$/ do |nombre, tipo, costo, unidades|
  @tipoRecurso = TipoRecurso.find_by_nombre (tipo)

  @recurso.nombre = nombre
  @recurso.tipo_recurso_id = @tipoRecurso.id
  @recurso.costo = costo
  @recurso.unidades = unidades

  if(!@recurso.save())
    raise "fallo"
  end
end
