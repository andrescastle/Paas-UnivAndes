# = Controlador de Tipos de Organizacions
# Esta clase implementa el controlador en el patron MVC para la tabla de tipos de organizacions.
# Un tipo de organizacion es una clasificacion de las organizacions que pueden ser utilizados en diferentes proyectos.
class TipoOrganizacionsController < ApplicationController
  before_filter :authenticate_user!

  # ===  Accion Index
  # Lista todos los tipos de organizacions y los visualiza en una grilla
  # GET /tipo_organizacions
  # GET /tipo_organizacions.json
  def index
    @tipo_organizacions = TipoOrganizacion.all
    @var=1
    @tipo_organizacion = TipoOrganizacion.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tipo_organizacions }
    end
  end

  # ===  Accion Show
  # Presenta la informacion de un tipo de organizacion de acuerdo al id enviado
  # GET /tipo_organizacions/1
  # GET /tipo_organizacions/1.json
  def show
    @tipo_organizacion = TipoOrganizacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tipo_organizacion }
    end
  end

  # ===  Accion New
  # Presenta el formulario para la creacion de un tipo de organizacion
  # GET /tipo_organizacions/new
  # GET /tipo_organizacions/new.json
  def new
    @tipo_organizacion = TipoOrganizacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tipo_organizacion }
    end
  end

  # ===  Accion edit
  # Presenta el formulario para la edicion de un tipo de organizacion de acuerdo al id enviado
  # GET /tipo_organizacions/1/edit
  def edit
    @tipo_organizacion = TipoOrganizacion.find(params[:id])
  end

  # ===  Accion create
  # Crea un tipo de organizacion de acuerdo a los datos enviados en el formulario de creacion
  # POST /tipo_organizacions
  # POST /tipo_organizacions.json
  def create
    @tipo_organizacion = TipoOrganizacion.new(params[:tipo_organizacion])

    respond_to do |format|
      if @tipo_organizacion.save
        @tipo_organizacion = TipoOrganizacion.new
        @tipo_organizacions = TipoOrganizacion.all.sort_by(&:created_at).reverse
        @message = t('datos_guardados')
        format.html { render action: "index" }
        format.json { render json: @tipo_organizacions }
      else
        format.html { render action: "new" }
        format.json { render json: @tipo_organizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # ===  Accion update
  # Actualiza un tipo de organizacion de acuerdo a los datos enviados en el formulario de edicion
  # PUT /tipo_organizacions/1
  # PUT /tipo_organizacions/1.json
  def update
    @tipo_organizacion = TipoOrganizacion.find(params[:id])

    respond_to do |format|
      if @tipo_organizacion.update_attributes(params[:tipo_organizacion])
        format.html { redirect_to @tipo_organizacion, notice: 'Tipo organizacion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tipo_organizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # ===  Accion destroy
  # Elimina un tipo de organizacion de acuerdo al id enviado
  # DELETE /tipo_organizacions/1
  # DELETE /tipo_organizacions/1.json
  def destroy
    @tipo_organizacion = TipoOrganizacion.find(params[:id])
    @tipo_organizacion.destroy

    respond_to do |format|
      format.html { redirect_to tipo_organizacions_url }
      format.json { head :no_content }
    end
  end

# ===  Accion existe
# Determina si existe un tipo de organizacion de acuerdo a un nombre
# * GET /tipo_organizacion/exist/nombre
  def existe
    @tipo_organizacion = TipoOrganizacion.find_by_name(params[:nombre])
    if(@tipo_organizacion)
      render :text => "true"
    else
      render :text => "false"
    end
  end
end