class TareaAprobacionsController < ApplicationController
  # GET /tarea_aprobacions
  # GET /tarea_aprobacions.json
  def index
    @tarea_aprobacions = TareaAprobacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tarea_aprobacions }
    end
  end

  # GET /tarea_aprobacions/1
  # GET /tarea_aprobacions/1.json
  def show
    @tarea_aprobacion = TareaAprobacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tarea_aprobacion }
    end
  end

  # GET /tarea_aprobacions/new
  # GET /tarea_aprobacions/new.json
  def new
    @tarea_aprobacion = TareaAprobacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tarea_aprobacion }
    end
  end

  # GET /tarea_aprobacions/1/edit
  def edit
    @tarea_aprobacion = TareaAprobacion.find(params[:id])
  end

  # POST /tarea_aprobacions
  # POST /tarea_aprobacions.json
  def create
    @tarea_aprobacion = TareaAprobacion.new(params[:tarea_aprobacion])

    respond_to do |format|
      if @tarea_aprobacion.save
        format.html { redirect_to @tarea_aprobacion, notice: 'Tarea aprobacion was successfully created.' }
        format.json { render json: @tarea_aprobacion, status: :created, location: @tarea_aprobacion }
      else
        format.html { render action: "new" }
        format.json { render json: @tarea_aprobacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tarea_aprobacions/1
  # PUT /tarea_aprobacions/1.json
  def update
    @tarea_aprobacion = TareaAprobacion.find(params[:id])

    respond_to do |format|
      if @tarea_aprobacion.update_attributes(params[:tarea_aprobacion])
        format.html { redirect_to @tarea_aprobacion, notice: 'Tarea aprobacion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tarea_aprobacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tarea_aprobacions/1
  # DELETE /tarea_aprobacions/1.json
  def destroy
    @tarea_aprobacion = TareaAprobacion.find(params[:id])
    @tarea_aprobacion.destroy

    respond_to do |format|
      format.html { redirect_to tarea_aprobacions_url }
      format.json { head :no_content }
    end
  end
end
