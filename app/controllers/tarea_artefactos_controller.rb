class TareaArtefactosController < ApplicationController
  # GET /tarea_artefactos
  # GET /tarea_artefactos.json
  before_filter :authenticate_user!

  def index
    @tarea_artefactos = TareaArtefacto.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tarea_artefactos }
    end
  end

  # GET /tarea_artefactos/1
  # GET /tarea_artefactos/1.json
  def show
    @tarea_artefacto = TareaArtefacto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tarea_artefacto }
    end
  end

  # GET /tarea_artefactos/new
  # GET /tarea_artefactos/new.json
  def new
    @tarea_artefacto = TareaArtefacto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tarea_artefacto }
    end
  end

  # GET /tarea_artefactos/1/edit
  def edit
    @tarea_artefacto = TareaArtefacto.find(params[:id])
  end

  # POST /tarea_artefactos
  # POST /tarea_artefactos.json
  def create
    @tarea = Tarea.find(params[:tarea_seleccionada])

    @tarea_artefactos = TareaArtefacto.find_all_by_tarea_id(@tarea.id)
    @artefactos = params[:artefactos]
    if @artefactos != nil then

      @tarea_artefactos.each do |tarea_artefacto|
        tarea_artefacto.delete
      end

      @artefactos.each do |tarea_razuna_key|

        _artefacto_id = 0;
        if(Artefacto.find_by_razuna_key(tarea_razuna_key) != nil) then
          _artefacto_id = Artefacto.find_by_razuna_key(tarea_razuna_key).id
        else
           @artefacto = Artefacto.new(
               :nombre => params[tarea_razuna_key],
               :razuna_key => tarea_razuna_key
           )

           @artefacto.save!

          _artefacto_id = Artefacto.last().id
        end

        @tarea_artefacto = TareaArtefacto.new(
            :artefacto_id => _artefacto_id,
            :tarea_id => params[:tarea_seleccionada],
            :modo => "In"
        )

        if @tarea_artefacto.save then
          @proyecto_artefactos = ProyectoArtefacto.find_all_by_proyecto_id_and_artefacto_id(@tarea.proceso.proyecto_id, @tarea_artefacto.artefacto_id)
          if @proyecto_artefactos.count() == 0 then

            @proyecto_artefacto = ProyectoArtefacto.new(
                :artefacto_id => @tarea_artefacto.artefacto_id,
                :proyecto_id => @tarea.proceso.proyecto_id
            )

            @proyecto_artefacto.save
          end
        else
          respond_to do |format|
            format.html { render action: "new" }
            format.json { render json: @tarea_artefacto.errors, status: :unprocessable_entity }
          end

          break

        end

      end

    end

    redirect_to request.protocol + request.host_with_port + "/tareas?proceso_id=" + @tarea.proceso_id.to_s()

  end

  # PUT /tarea_artefactos/1
  # PUT /tarea_artefactos/1.json
  def update
    @tarea_artefacto = TareaArtefacto.find(params[:id])

    respond_to do |format|
      if @tarea_artefacto.update_attributes(params[:tarea_artefacto])
        format.html { redirect_to @tarea_artefacto, notice: 'Tarea artefacto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tarea_artefacto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tarea_artefactos/1
  # DELETE /tarea_artefactos/1.json
  def destroy
    @tarea_artefacto = TareaArtefacto.find(params[:id])
    @tarea_artefacto.destroy

    respond_to do |format|
      format.html { redirect_to tarea_artefactos_url }
      format.json { head :no_content }
    end
  end
end
