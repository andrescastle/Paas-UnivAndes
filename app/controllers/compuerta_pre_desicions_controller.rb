class CompuertaPreDesicionsController < ApplicationController
  # GET /compuerta_pre_desicions
  # GET /compuerta_pre_desicions.json
  def index
    @compuerta_pre_desicions = CompuertaPreDesicion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @compuerta_pre_desicions }
    end
  end

  # GET /compuerta_pre_desicions/1
  # GET /compuerta_pre_desicions/1.json
  def show
    @compuerta_pre_desicion = CompuertaPreDesicion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @compuerta_pre_desicion }
    end
  end

  # GET /compuerta_pre_desicions/new
  # GET /compuerta_pre_desicions/new.json
  def new
    @compuerta_pre_desicion = CompuertaPreDesicion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @compuerta_pre_desicion }
    end
  end

  # GET /compuerta_pre_desicions/1/edit
  def edit
    @compuerta_pre_desicion = CompuertaPreDesicion.find(params[:id])
  end

  # POST /compuerta_pre_desicions
  # POST /compuerta_pre_desicions.json
  def create


    params[:cantidad].to_i.times do |count|

      if params[:compuerta_pre]
        @compuerta_pre_desicion = CompuertaPreDesicion.find(params[:compuerta_pre][count.to_s])
      else
        @compuerta_pre_desicion = CompuertaPreDesicion.new
      end

      @compuerta_pre_desicion.compuerta_id = params[:compuerta_id]
      @compuerta_pre_desicion.tarea_desicion_id = params[:tarea_desicion_id]
      @compuerta_pre_desicion.ruta_id = params[:compuerta_ruta][count.to_s]
      if params[:compuerta_type] == 'compuerta_exclu'
        @compuerta_pre_desicion.elegida = params[:compuerta_ruta][count.to_s] == params[:elegida]
      else
        if params[:ruta]
          @compuerta_pre_desicion.elegida = params[:compuerta_ruta][count.to_s] == params[:ruta][count.to_s]
        else
          @compuerta_pre_desicion.elegida = false
        end

      end

      @compuerta_pre_desicion.save

    end
    #@compuerta_pre_desicion = CompuertaPreDesicion.new(params[:compuerta_pre_desicion])

    respond_to do |format|
      if @compuerta_pre_desicion.save
        format.html { redirect_to "/tarea_participantes", notice: 'Compuerta pre desicion was successfully created.' }
        format.json { render json: @compuerta_pre_desicion, status: :created, location: @compuerta_pre_desicion }
      else
        format.html { render action: "new" }
        format.json { render json: @compuerta_pre_desicion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /compuerta_pre_desicions/1
  # PUT /compuerta_pre_desicions/1.json
  def update
    @compuerta_pre_desicion = CompuertaPreDesicion.find(params[:id])

    respond_to do |format|
      if @compuerta_pre_desicion.update_attributes(params[:compuerta_pre_desicion])
        format.html { redirect_to @compuerta_pre_desicion, notice: 'Compuerta pre desicion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @compuerta_pre_desicion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compuerta_pre_desicions/1
  # DELETE /compuerta_pre_desicions/1.json
  def destroy
    @compuerta_pre_desicion = CompuertaPreDesicion.find(params[:id])
    @compuerta_pre_desicion.destroy

    respond_to do |format|
      format.html { redirect_to compuerta_pre_desicions_url }
      format.json { head :no_content }
    end
  end
end
