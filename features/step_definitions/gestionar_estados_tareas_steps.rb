# language: es
# = Gestionar estados tareas

####################################################################################################
# TODO:
####################################################################################################

# Gestionar estados
Dado /^que en gestionar estados soy usuario (.*)$/ do |nombre|
	@usuario = Usuario.create(
	:nombre => @nombre,
	:login => @nombre)
end

Cuando /^en gestionar estados estoy en la pagina (.*)$/ do |pagina|
	visit pagina
end

Y /^en gestionar estados consulto la tarea (.*)$/ do |tarea|
	@tarea = Tarea.new( # creamos la tarea
	:nombre => @tarea
	)
end

Y /^su estado es (.*)$/ do |estado|
	@tarea.estado = @estado
	@tarea.save
	@tarea_participante = TareaParticipante.create( # creamos asociacion usuario tarea
	:tarea_id => @tarea.id,
	:usuario_id => @usuario.id
	)	
	
	# Guardamos cambio de estado.
	@estado_tarea = EstadoTarea.new
	@estado_tarea.tareas_id=@tarea.id
	@estado_tarea.estado_actividads_id=@tarea.estado
	@estado_tarea.save	
end

Y /^ahora su estado es (.*)$/ do |estado|

	# Guardamos estado nuevo.
	@estado_nuevo = @estado
	@tarea.estado = @estado
	@tarea.save
	
	# Guardamos cambio de estado.
	@estado_tarea = EstadoTarea.new
	@estado_tarea.tareas_id=@tarea.id
	@estado_tarea.estado_actividads_id=@tarea.estado
	@estado_tarea.save
end

Entonces /^se espera que se muestre el estado (.*)$/ do |estado|

	if !@tarea.estado == estado
		raise('Fallo')
	end
end

Y /^NO el estado (.*)$/ do |estado|

	if @tarea.estado == estado
		raise('Fallo')
	end
end

Y /^quede registrado en un log de estados/ do

	@estados_tarea = EstadoTarea.all
	@yes = 'KO'
	@estados_tarea.each do | e |
		if e.tareas_id == @tarea.id && e.estado_actividads_id == @estado_nuevo
		
			@yes = 'OK' # definimos un resultado correcto
		end
	end	
	
	if @yes == 'KO'
		raise('Fallo')
	end
end
