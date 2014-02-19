include ProcessRulesHelper

class TareaRevisionsController < ApplicationController
  # GET /tarea_revisions
  # GET /tarea_revisions.json
  def index
    @tarea_revisions = TareaRevision.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tarea_revisions }
    end
  end

  # GET /tarea_revisions/1
  # GET /tarea_revisions/1.json
  def show
    @tarea_revision = TareaRevision.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tarea_revision }
    end
  end

  # GET /tarea_revisions/new
  # GET /tarea_revisions/new.json
  def new
    @tarea_revision = TareaRevision.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tarea_revision }
    end
  end

  # GET /tarea_revisions/1/edit
  def edit
    @tarea_revision = TareaRevision.find(params[:id])
  end

  # POST /tarea_revisions
  # POST /tarea_revisions.json
  def create

    @latarea = Tarea.find(params[:tarea_revision][:tarea_id])

    @tarea_revision = TareaRevision.find_or_create_by_tarea_id_and_usuario_id(@latarea.tarea_revisar_id, params[:tarea_revision][:usuario_id])
    @tarea_revision.comentario = params[:tarea_revision][:comentario]
    @tarea_revision.aprobado = params[:tarea_revision][:aprobado]

    @tarea_apr = TareaAprobacion.new
    @tarea_apr.tarea_id = @latarea.tarea_revisar_id
    @tarea_apr.usuario_id = params[:tarea_revision][:usuario_id]
    @tarea_apr.aprobado = params[:tarea_revision][:aprobado]
    @tarea_apr.comentario = params[:tarea_revision][:comentario]
    @tarea_apr.save!

      if @tarea_revision.save!

        eventos_proceso @latarea.proceso

        redirect_to request.protocol + request.host_with_port + "/tarea_participantes"
      else
      respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @tarea_revision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tarea_revisions/1
  # PUT /tarea_revisions/1.json
  def update
    @tarea_revision = TareaRevision.find(params[:id])
    respond_to do |format|
      if @tarea_revision.update_attributes(params[:tarea_revision])
        format.html { redirect_to @tarea_revision, notice: 'Tarea revision was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tarea_revision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tarea_revisions/1
  # DELETE /tarea_revisions/1.json
  def destroy
    @tarea_revision = TareaRevision.find(params[:id])
    @tarea_revision.destroy

    respond_to do |format|
      format.html { redirect_to tarea_revisions_url }
      format.json { head :no_content }
    end
  end

  def revisor

    if params[:revisor] == '0'
      @tarea_revision = TareaRevision.where(:turno => params[:turno]).where(:tarea_id => params[:tarea]).first
      @tarea_revision.destroy
      render :text => "true"
    else

      #crear nueva tarea
      tarea = Tarea.find(params[:tarea])
      laactividad = Actividad.find(tarea.actividad_id)
      @tarea_nueva = Tarea.new
      @tarea_nueva.nombre = "Revision de "+tarea.nombre
      @tarea_nueva.descripcion = "Revision de una tarea que requiere aprobacion"
      @tarea_nueva.actividad_id = tarea.actividad_id
      @tarea_nueva.proceso_id = tarea.proceso_id
      @tarea_nueva.responsable_id = params[:revisor]
      @tarea_nueva.estado = 1
      @tarea_nueva.columna = 1
      @tarea_nueva.duracion = 1
      @tarea_nueva.horas_planeadas = 1
      @tarea_nueva.es_aprobacion = true
      @tarea_nueva.tarea_revisar_id = params[:tarea]
      @tarea_nueva.save

      @tarea_participante = TareaParticipante.new(
          :usuario_id => params[:revisor],
          :dedicacion => 1,
          :tarea_id => @tarea_nueva.id
      )

      @tarea_participante.save


      #actualizar o crear precedencias
      #Permission.find_or_create_by_user_id_and_role_id_and_creator_id(@user.id, 2, current_user.id)


      @tareapres

      if params[:turno] == "1" || laactividad.modo_revision != "sequ"
        @tareapres = TareaPresedencium.find_or_create_by_predecesora_id_and_sucesora_id_and_tipo_relacion(
            params[:tarea],
            "",
            "revision"
        )
      elsif params[:turno] == ''

        @tareapres2 = TareaPresedencium.find_or_create_by_predecesora_id_and_tipo_relacion(
            @tarea_nueva.tarea_revisar_id,
            "revision"
        )
        @tareapres2.sucesora_id = @tarea_nueva.id
        @tareapres2.save
      else

        ant_tarea_rev = TareaRevision.where(:turno => ( params[:turno].to_f - 1)).where(:tarea_id => params[:tarea]).first
        @tareapres2 = TareaPresedencium.find_or_create_by_predecesora_id_and_tipo_relacion(
            ant_tarea_rev.tarea_id,
            "revision"
        )
        @tareapres2.sucesora_id = @tarea_nueva.id
        @tareapres2.save
        @tareapres = TareaPresedencium.find_or_create_by_predecesora_id_and_sucesora_id_and_tipo_relacion(
            @tarea_nueva.id,
            "",
            "revision"
        )

      end




      #actualizar o crear tarea revision
      @tarea_revision = TareaRevision.where(:turno => params[:turno]).where(:tarea_id => params[:tarea]).first

      if TareaRevision.where(:turno => params[:turno]).where(:tarea_id => params[:tarea]).count > 0

        @tarea_revision.usuario_id = params[:revisor]
        @tarea_revision.save
        render :text => "true"
      else
        @tarea_revision = TareaRevision.new

        @tarea_revision.tarea_id = params[:tarea]
        @tarea_revision.usuario_id = params[:revisor]
        @tarea_revision.turno = params[:turno]

        @tarea_revision.save

        render :text => "true"
      end

    end

  end
end
