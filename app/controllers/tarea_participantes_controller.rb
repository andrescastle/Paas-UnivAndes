include ProcessRulesHelper

class TareaParticipantesController < ApplicationController
  before_filter :authenticate_user!
  # GET /tarea_participantes
  # GET /tarea_participantes.json

  def index
    @usuario=Usuario.find_by_id(current_user.id)

    @tareas_rev = Tarea.where("responsable_id = " + @usuario.id.to_s + " and es_aprobacion = 1").order("prioridad ASC").all

    @tareas_rev.each do |tarea|
      tarea_participante = TareaParticipante.find_by_usuario_id_and_tarea_id(@usuario.id, tarea.id)
      if(tarea_participante == nil)
        TareaParticipante.new(:tarea_id => tarea.id, :usuario_id => @usuario.id, :dedicacion => 4, :prioridad => 1).save!
      end
    end

    @tareasP = TareaParticipante.where(:usuario_id => @usuario.id).order("prioridad ASC").all
    @tareas = @usuario.tareas.order("prioridad ASC").all

    @tarea_revision = TareaRevision.new
    @compuerta_pre_desicion = CompuertaPreDesicion.new
    @tarea_artefacto = TareaArtefacto.new

   # if(@tareas.count > 0)
   #   @tarea_participante = @tareaP[0]
   # else
    #   @tarea_participante = nil
   # end

    #@actividades = Array.new
    #@tareas.each do |tarea_participante|
    #  @actividades.push(tarea_participante.tarea.actividad)
    #end

    # a continuacion llenar la info del grafico de estado tareas por proc

    @cant_proceso_poriniciar_plan = 0
    @cant_proceso_enprogreso_plan = 0
    @cant_proceso_terminadas_plan = 0
    @cant_proceso_poriniciar_real = 0
    @cant_proceso_enprogreso_real = 0
    @cant_proceso_terminadas_real = 0

    @col1_real = 0
    @col2_real = 0
    @col3_real = 0
    @col1_plan = 0
    @col2_plan = 0
    @col3_plan = 0

    @tareas.each do |tarea|
      if(tarea.fecha_inicio != nil)

        if tarea.fecha_inicio > Date.today && tarea.fecha_fin < Date.today
           @col2_plan = @col2_plan + 1
        elsif Date.today > tarea.fecha_fin
           @col3_plan = @col3_plan + 1
        elsif Date.today < tarea.fecha_inicio
           @col1_plan = @col1_plan + 1
        end
      end

        if tarea.columna == 1
          @col1_real = @col1_real + 1
        elsif tarea.columna == 2
          @col2_real = @col2_real + 1
        elsif tarea.columna == 3
          @col3_real = @col3_real + 1
        end
      end

      @cant_proceso_poriniciar_plan = @col1_plan
      @cant_proceso_enprogreso_plan = @col2_plan
      @cant_proceso_terminadas_plan = @col3_plan
      @cant_proceso_poriniciar_real = @col1_real
      @cant_proceso_enprogreso_real = @col2_real
      @cant_proceso_terminadas_real = @col3_real

    respond_to do |format|
      format.html { render 'index', :layout => 'WS_usuarios'}# show.html.erb
      format.json { render 'index', :layout => 'WS_usuarios'}#render json: @proyecto }
    end

  end


  def updateHoras
    @usuario=Usuario.find_by_id(current_user.id)
    @tarea = Tarea.find(params[:tarea])

    if @tarea.update_attribute("horas_ejecutadas", params[:horas])
      @tarea_participante=TareaParticipante.find_by_tarea_id_and_usuario_id(@tarea.id, @usuario.id)
      if @tarea_participante.update_attribute("ejecutadas", params[:horas])

        render :text => "true"
      else
        render :text => "false"
      end
    else
      render :text => "false"
    end
  end

  def updateEstado
    @tarea = Tarea.find(params[:tarea])
    @usuario=Usuario.find_by_id(current_user.id)

    continuar = true

    # respond_to do |format|
    if @tarea.es_desicion && params[:columna] == "3"
      @lasdecisiones = CompuertaPreDesicion.find_all_by_tarea_desicion_id_and_elegida(@tarea.id, true)
      if @lasdecisiones && @lasdecisiones.count > 0
        @lastemporales = CompuertaPreDesicion.find_all_by_tarea_desicion_id(@tarea.id)
        @lastemporales.each do |unatemp|
          @compuerta_decision = CompuertaDesicion.new
          @compuerta_decision.compuerta_id = unatemp.compuerta_id
          @compuerta_decision.ruta_id = unatemp.ruta_id
          @compuerta_decision.elegida = unatemp.elegida
          @compuerta_decision.tarea_desicion_id = unatemp.tarea_desicion_id
          @compuerta_decision.save
        end

        continuar = true
      else
        continuar = false
        render :text => "youcant"
      end
    end

    puts continuar


    if continuar && @tarea.update_attribute("columna", params[:columna]) #update_attributes(params[:actividad])


      if(@tarea.actividad_id != nil)

        @actividad=Actividad.find(@tarea.actividad_id)
        @rev=@actividad.modo_revision

        if(!@tarea.es_aprobacion && (@rev=="sequ" || @rev=="para"))
         @revision=1
        else
          @revision=0
        end
      else #es tarea de decisión siempre
        @revision=0
      end

      if @tarea.estado==1 #|| @tarea.estado==2
        if params[:columna]=="2"
          @tarea.update_attribute("estado",5)
          @tarea.update_attribute("columna",2)
          @tarea.update_attribute("horas_ejecutadas",0)
          @tarea.update_attribute("avance",0)
        end
      elsif @tarea.estado==5
         if params[:columna]=="1"
           @tarea.update_attribute("estado",1)
           @tarea.update_attribute("columna",1)
           @tarea.update_attribute("horas_ejecutadas",0)
           @tarea.update_attribute("avance",0)
         elsif params[:columna]=="3"
           if @revision==1
             @tarea.update_attribute("estado",11)
             @tarea.update_attribute("columna",3)
             @tarea.update_attribute("avance",100)
           else
             @tarea.update_attribute("estado",8)
             @tarea.update_attribute("columna",4)
             @tarea.update_attribute("avance",100)
           end
         end
      elsif @tarea.estado==11
        if params[:columna]=="1"
          @tarea.update_attribute("estado",1)
          @tarea.update_attribute("columna",1)
          @tarea.update_attribute("horas_ejecutadas",0)
          @tarea.update_attribute("avance",100)
        elsif params[:columna]=="2"
          @tarea.update_attribute("estado",5)
          @tarea.update_attribute("columna",2)
          @tarea.update_attribute("horas_ejecutadas",0)
        end
      end

      if(@tarea.horas_acumuladas == nil)
        @tarea.horas_acumuladas = 0
      end

      if(@tarea.columna == 3 || @tarea.columna == 4)
        @tarea.update_attribute("horas_acumuladas", @tarea.horas_acumuladas + @tarea.horas_ejecutadas)
      else
        if(@tarea.horas_acumuladas - @tarea.horas_ejecutadas > 0)
          @tarea.update_attribute("horas_acumuladas", @tarea.horas_acumuladas - @tarea.horas_ejecutadas)
        end
      end

      if(@tarea.columna == 3 || @tarea.columna == 4)
        eventos_proceso @tarea.proceso
      end

      if(@tarea.es_aprobacion)
        _tarea_revisar = Tarea.find(@tarea.tarea_revisar_id)
        _tarea_revisar.estado = 8
        _tarea_revisar.columna = 4
        _tarea_revisar.save!
      end

      @estado_tarea = EstadoTarea.new
      @estado_tarea.tareas_id=@tarea.id
      @estado_tarea.estado_actividads_id=@tarea.estado
      @estado_tarea.usuario_id=@usuario.id

      if @estado_tarea.save
        if @revision==0 &&  params[:columna]=="3"
          render :text => @tarea.columna.to_s + ":" + @tarea.horas_acumuladas.to_s + ":" + @tarea.horas_ejecutadas.to_s + ":" + @tarea.avance.to_s + ":true"
        else
          render :text => @tarea.columna.to_s + ":" + @tarea.horas_acumuladas.to_s + ":" + @tarea.horas_ejecutadas.to_s + ":" + @tarea.avance.to_s + ":false"
        end
      else
        render :text => "false"
      end
    end
    # end
  end

  # GET /tarea_participantes/1
  # GET /tarea_participantes/1.json
  def show
    @tarea_participante = TareaParticipante.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tarea_participante }
    end
  end

  # GET /tarea_participantes/new
  # GET /tarea_participantes/new.json
  def new
    @tarea_participante = TareaParticipante.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tarea_participante }
    end
  end

  # GET /tarea_participantes/1/edit
  def edit
    @tarea_participante = TareaParticipante.find(params[:id])
  end

  # POST /tarea_participantes
  # POST /tarea_participantes.json
  def create

    @tarea = Tarea.find(params[:tarea_seleccionada])

    @tarea_participantes = TareaParticipante.find_all_by_tarea_id(@tarea.id)
    participante_id = params[:participante_id]
    if participante_id != nil then

      @tarea.responsable_id = params[:participante_id]
      @tarea.save!

      @tarea_participantes.each do |tarea_participante|
        tarea_participante.delete
      end

     # @participantes.each do |participante_id|

      @dedicacion = "dedicacion_" + participante_id.to_s()

      @tarea_participante = TareaParticipante.new(
        :usuario_id => participante_id,
        :dedicacion => params[@dedicacion],
        :tarea_id => params[:tarea_seleccionada]
      )

      if @tarea_participante.save then
        @proyecto_usuarios = ProyectoUsuario.find_all_by_proyecto_id_and_usuario_id(@tarea.proceso.proyecto_id, @tarea_participante.usuario_id)
        if @proyecto_usuarios.count() == 0 then

          @proyecto_usuario = ProyectoUsuario.new(
              :usuario_id => @tarea_participante.usuario_id,
              :proyecto_id => @tarea.proceso.proyecto_id
           )

          @proyecto_usuario.save
        end

        begin
        @permisos = '[["group_id","2"]]'
        _usuario = Usuario.find(@tarea_participante.usuario_id)
        _url = ENV['root_razuna_api'] + "/global/api2/user.cfc?method=update&api_key=" + ENV['admindavid_razuna_key'] + "&useremail=" + _usuario.email + "&userdata=" + @permisos + "&__BDRETURNFORMAT=wddx"
        @wddx = WDDX.load(open(_url))
        rescue

        end

      else
        respond_to do |format|
          format.html { render action: "new" }
          format.json { render json: @tarea_participante.errors, status: :unprocessable_entity }
        end

        #break

      end

   # end

    end

    redirect_to request.protocol + request.host_with_port + "/tareas?proceso_id=+" + @tarea.proceso_id.to_s()

  end

  # PUT /tarea_participantes/1
  # PUT /tarea_participantes/1.json
  def update
    #@tarea_participante = TareaParticipante.find(params[:id])

    @tarea = Tarea.find(params[:tarea_id])
    @tarea.avance = params[:tarea_avance]
    @tarea.horas_ejecutadas = params[:tarea_horasexec]



    if params[:tarea_aprobacion] != nil then

      TareaRevision.destroy_all("tarea_id ="+ params[:tarea_id].to_s + " and usuario_id =" + params[:usuario_id].to_s)

      @tarea_revision = TareaRevision.new(
          :tarea_id =>  params[:tarea_id],
          :usuario_id => params[:usuario_id],
          :aprobado => params[:tarea_aprobacion],
          :comentario => params[:tarea_comentario]
      )

      if @tarea_revision.save!
        if(@tarea_revision.aprobado)
          @tarea.estado = 8
          @tarea.columna = 4
        else
          @tarea.estado = 1
          @tarea.columna = 1
        end
      end
    end

    if(@tarea.save) then
        redirect_to request.protocol + request.host_with_port + "/tarea_participantes"
    else
      respond_to do |format|
      format.html { render action: "edit" }
      format.json { render json: @tarea.errors, status: :unprocessable_entity }
      end
    end

    end
  # DELETE /tarea_participantes/1
  # DELETE /tarea_participantes/1.json
  def destroy
    @tarea_participante = TareaParticipante.find(params[:id])
    @tarea_participante.destroy

    respond_to do |format|
      format.html { redirect_to tarea_participantes_url }
      format.json { head :no_content }
    end
  end
end
