# language: es
# =  Ver tareas asignadas

####################################################################################################
# TODO:
####################################################################################################

# Gestionar tiempo de duracion
Dado /^que en gestionar soy usuario (.*)$/ do |nombre|
	@usuario = Usuario.create(
	:nombre => @nombre,
	:login => @nombre)
end

Cuando /^en gestionar estoy en la pagina (.*)$/ do |pagina|
	visit pagina
end

Y /^en gestionar consulto la tarea (.*)$/ do |tarea|
	@tarea = Tarea.new( # creamos la tarea
	:nombre => @tarea
	)
end

Y /^la duracion (\d+)$/ do |duracion|
	@tarea.horas_ejecutadas = @duracion
	@tarea.save
	@tarea_participante = TareaParticipante.create( # creamos asociacion usuario tarea
	:tarea_id => @tarea.id,
	:usuario_id => @usuario.id
	)	
end

Y /^ahora la duracion es (\d+)$/ do |duracion|
	@tarea.horas_ejecutadas = @duracion
	@tarea.save
end

Entonces /^se espera que se muestre la duracion (\d+)$/ do |duracion|
	if !@tarea.horas_ejecutadas == duracion
		raise('Fallo')
	end
end

Y /^NO la duracion (\d+)$/ do |duracion|
	if @tarea.duracion == duracion
		raise('Fallo')
	end
end
