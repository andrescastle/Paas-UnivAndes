# language: es
# =  Ver tareas asignadas

####################################################################################################
# TODO:
####################################################################################################

# Ver tareas de un usuario
Dado /^que soy usuario (.*)$/ do |nombre|
	@usuario = Usuario.create(
	:nombre => @nombre,
	:login => @nombre)
end

Cuando /^estoy en la pagina (.*)$/ do |pagina|
	visit pagina
end

Entonces /^se espera que se muestre la tarea (.*)$/ do |tarea|
	@tarea = Tarea.create( # creamos la tarea
	:nombre => @tarea
	)
	@tarea_participante = TareaParticipante.create( # creamos asociacion usuario tarea
	:tarea_id => @tarea.id,
	:usuario_id => @usuario.id
	)
	#@usuario.save # TODO: Verificar si hay que hacerlo aunque guarde la asociacion
	@tareas = @usuario.tareas.all # Consultamos tareas del usuario
	@resultado = 'KO' # definimos un resultado
	@tareas.each do | t |
		if @tarea.id == t.id
		
			@resultado = 'OK' # definimos un resultado correcto
		end
	end	
	if @resultado == 'KO'
		raise('Fallo')
	end
end

Y /^la tarea (.*)$/ do |tarea|
	@tarea = Tarea.create( # creamos la tarea
	:nombre => @tarea
	)
	@tarea_participante = TareaParticipante.create( # creamos asociacion usuario tarea
	:tarea_id => @tarea.id,
	:usuario_id => @usuario.id
	)
	@tareas = @usuario.tareas.all # Consultamos tareas del usuario
	@resultado = 'KO' # definimos un resultado
	@tareas.each do | t |
		if @tarea.id == t.id
		
			@resultado = 'OK' # definimos un resultado correcto
		end
	end	
	if @resultado == 'KO'
		raise('Fallo')
	end
end

Y /^NO se muestre la tarea (.*)$/ do |tarea|
	@tarea = Tarea.create( # creamos la tarea
	:nombre => @tarea
	)
	#@tarea_participante = TareaParticipante.create( # creamos asociacion usuario tarea
	#:tarea_id => @tarea.id,
	#:usuario_id => @usuario.id
	#)
	@tareas = @usuario.tareas.all # Consultamos tareas del usuario
	@resultado = 'OK' # definimos un resultado
	@tareas.each do | t |
		if @tarea.id == t.id
		
			@resultado = 'KO' # definimos un resultado correcto
		end
	end	
	if @resultado == 'KO'
		raise('Fallo')
	end
end
