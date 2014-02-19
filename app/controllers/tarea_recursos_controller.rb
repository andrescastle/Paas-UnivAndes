class TareaRecursosController < ApplicationController
  # GET /tarea_recursos
  # GET /tarea_recursos.json
  before_filter :authenticate_user!

  def index
    @tarea_recursos = TareaRecurso.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tarea_recursos }
    end
  end

  # GET /tarea_recursos/1
  # GET /tarea_recursos/1.json
  def show
    @tarea_recurso = TareaRecurso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tarea_recurso }
    end
  end

  # GET /tarea_recursos/new
  # GET /tarea_recursos/new.json
  def new
    @tarea_recurso = TareaRecurso.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tarea_recurso }
    end
  end

  # GET /tarea_recursos/1/edit
  def edit
    @tarea_recurso = TareaRecurso.find(params[:id])
  end

  # POST /tarea_recursos
  # POST /tarea_recursos.json
  def create
    @tarea = Tarea.find(params[:tarea_seleccionada])

    @tarea_recursos = TareaRecurso.find_all_by_tarea_id(@tarea.id)

    @recursos = params[:recurso]
    if @recursos != nil then

      @tarea_recursos.each do |tarea_recurso|
        tarea_recurso.delete
      end

    @recursos.each do |recurso_id|

      @unidades = "qty_recurso_" + recurso_id.to_s()

      if params[@unidades] != "0" then

        @tarea_recurso = TareaRecurso.new(
            :recurso_id => recurso_id,
            :unidades => params[@unidades],
            :tarea_id => params[:tarea_seleccionada]
        )

        if @tarea_recurso.save then

          @proyecto_recursos = ProyectoRecurso.find_all_by_proyecto_id_and_recurso_id(@tarea.proceso.proyecto_id, @tarea_recurso.recurso_id)
          if @proyecto_recursos.count() == 0 then

            @proyecto_recurso = ProyectoRecurso.new(
                :recurso_id => @tarea_recurso.recurso_id,
                :proyecto_id => @tarea.proceso.proyecto_id
            )

            @proyecto_recurso.save
          end
        else
          respond_to do |format|
            format.html { render action: "new" }
            format.json { render json: @tarea_recurso.errors, status: :unprocessable_entity }
          end
          break
        end
      end
    end

    end

    redirect_to request.protocol + request.host_with_port + "/tareas?proceso_id=+" + @tarea.proceso_id.to_s()

  end


  # PUT /tarea_recursos/1
  # PUT /tarea_recursos/1.json
  def update
    @tarea_recurso = TareaRecurso.find(params[:id])

    respond_to do |format|
      if @tarea_recurso.update_attributes(params[:tarea_recurso])
        format.html { redirect_to @tarea_recurso, notice: 'Tarea recurso was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tarea_recurso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tarea_recursos/1
  # DELETE /tarea_recursos/1.json
  def destroy
    @tarea_recurso = TareaRecurso.find(params[:id])
    @tarea_recurso.destroy

    respond_to do |format|
      format.html { redirect_to tarea_recursos_url }
      format.json { head :no_content }
    end
  end
end
