class ProyectoRecursosController < ApplicationController
  # GET /proyecto_recursos
  # GET /proyecto_recursos.json
  before_filter :authenticate_user!

  def index
    @proyecto_recursos = ProyectoRecurso.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @proyecto_recursos }
    end
  end

  # GET /proyecto_recursos/1
  # GET /proyecto_recursos/1.json
  def show
    @proyecto_recurso = ProyectoRecurso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @proyecto_recurso }
    end
  end

  # GET /proyecto_recursos/new
  # GET /proyecto_recursos/new.json
  def new
    @proyecto_recurso = ProyectoRecurso.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @proyecto_recurso }
    end
  end

  # GET /proyecto_recursos/1/edit
  def edit
    @proyecto_recurso = ProyectoRecurso.find(params[:id])
  end

  # POST /proyecto_recursos
  # POST /proyecto_recursos.json
  def create
    @proyecto_recurso = ProyectoRecurso.new(params[:proyecto_recurso])

    respond_to do |format|
      if @proyecto_recurso.save
        format.html { redirect_to @proyecto_recurso, notice: 'Proyecto recurso was successfully created.' }
        format.json { render json: @proyecto_recurso, status: :created, location: @proyecto_recurso }
      else
        format.html { render action: "new" }
        format.json { render json: @proyecto_recurso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /proyecto_recursos/1
  # PUT /proyecto_recursos/1.json
  def update
    @proyecto_recurso = ProyectoRecurso.find(params[:id])

    respond_to do |format|
      if @proyecto_recurso.update_attributes(params[:proyecto_recurso])
        format.html { redirect_to @proyecto_recurso, notice: 'Proyecto recurso was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @proyecto_recurso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proyecto_recursos/1
  # DELETE /proyecto_recursos/1.json
  def destroy
    @proyecto_recurso = ProyectoRecurso.find(params[:id])
    @proyecto_recurso.destroy

    respond_to do |format|
      format.html { redirect_to proyecto_recursos_url }
      format.json { head :no_content }
    end
  end
end
