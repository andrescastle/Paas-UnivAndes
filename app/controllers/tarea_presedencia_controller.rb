class TareaPresedenciaController < ApplicationController
  # GET /tarea_presedencia
  # GET /tarea_presedencia.json
  before_filter :authenticate_user!

  def index
    @tarea_presedencia = TareaPresedencium.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tarea_presedencia }
    end
  end

  # GET /tarea_presedencia/1
  # GET /tarea_presedencia/1.json
  def show
    @tarea_presedencium = TareaPresedencium.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tarea_presedencium }
    end
  end

  # GET /tarea_presedencia/new
  # GET /tarea_presedencia/new.json
  def new
    @tarea_presedencium = TareaPresedencium.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tarea_presedencium }
    end
  end

  # GET /tarea_presedencia/1/edit
  def edit
    @tarea_presedencium = TareaPresedencium.find(params[:id])
  end

  # POST /tarea_presedencia
  # POST /tarea_presedencia.json
  def create
    @tarea_presedencium = TareaPresedencium.new(params[:tarea_presedencium])

    respond_to do |format|
      if @tarea_presedencium.save
        format.html { redirect_to @tarea_presedencium, notice: 'Tarea presedencium was successfully created.' }
        format.json { render json: @tarea_presedencium, status: :created, location: @tarea_presedencium }
      else
        format.html { render action: "new" }
        format.json { render json: @tarea_presedencium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tarea_presedencia/1
  # PUT /tarea_presedencia/1.json
  def update
    @tarea_presedencium = TareaPresedencium.find(params[:id])

    respond_to do |format|
      if @tarea_presedencium.update_attributes(params[:tarea_presedencium])
        format.html { redirect_to @tarea_presedencium, notice: 'Tarea presedencium was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tarea_presedencium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tarea_presedencia/1
  # DELETE /tarea_presedencia/1.json
  def destroy
    @tarea_presedencium = TareaPresedencium.find(params[:id])
    @tarea_presedencium.destroy

    respond_to do |format|
      format.html { redirect_to tarea_presedencia_url }
      format.json { head :no_content }
    end
  end
end
