# = Controlador de Tipos de Recurso
# Esta clase implementa el controlador en el patron MVC para la tabla de tipos de recursos.
# Un tipo de recurso es una clasificacion de los recursos que pueden ser utilizados en diferentes proyectos.
class TipoRecursosController < ApplicationController
  before_filter :authenticate_user!
# ===  Accion Index
# Lista todos los tipos de recursos y los visualiza en una grilla
# * GET /tipo_recursos
# * GET /tipo_recursos.json
  def index
    @tipo_recursos = TipoRecurso.where(:unit => '2').all.sort_by(&:created_at).reverse
    @var=1
    @tipo_recurso = TipoRecurso.new
    # puts @tipo_recurso.unit => "1"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tipo_recursos }
    end
  end

# ===  Accion Show
# Presenta la informacion de un tipo de recurso de acuerdo al id enviado
# * GET /tipo_recursos/1
# * GET /tipo_recursos/1.json
  def show
    @tipo_recurso = TipoRecurso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tipo_recurso }
    end
  end

# ===  Accion New
# Presenta el formulario para la creacion de un tipo de recurso
# * GET /tipo_recursos/new
# * GET /tipo_recursos/new.json
  def new
    @tipo_recurso = TipoRecurso.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tipo_recurso }
    end
  end

# ===  Accion edit
# Presenta el formulario para la edicion de un tipo de recurso de acuerdo al id enviado
# * GET /tipo_recursos/1/edit
  def edit
    @tipo_recurso = TipoRecurso.find(params[:id])
  end

# ===  Accion create
# Crea un tipo de recurso de acuerdo a los datos enviados en el formulario de creacion
# * POST /tipo_recursos
# * POST /tipo_recursos.json
  def create
    @tipo_recurso = TipoRecurso.new(params[:tipo_recurso])
    tiprec = params[:tiprec]

      if @tipo_recurso.save
        if tiprec.to_s == "1"
          redirect_to request.protocol + request.host_with_port + "/rols"
        elsif tiprec.to_s == "2"
          respond_to do |format|
            @tipo_recurso = TipoRecurso.new
            @tipo_recursos = TipoRecurso.where(:unit => '2').all
            @message = t('datos_guardados')
            format.html { render action: "index" }
            format.json { render json: @tipo_recursos }
          end
        else
          respond_to do |format|
            format.html { render action: "new" }
            format.json { render json: @tipo_recurso.errors, status: :unprocessable_entity }
          end
      end
    end
  end

# ===  Accion update
# Actualiza un tipo de recurso de acuerdo a los datos enviados en el formulario de edicion
# * PUT /tipo_recursos/1
# * PUT /tipo_recursos/1.json
  def update
    @tipo_recurso = TipoRecurso.find(params[:id])

    respond_to do |format|
      if @tipo_recurso.update_attributes(params[:tipo_recurso])
        format.html { redirect_to @tipo_recurso, notice: 'Tipo recurso was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tipo_recurso.errors, status: :unprocessable_entity }
      end
    end
  end

# ===  Accion destroy
# Elimina un tipo de recurso de acuerdo al id enviado
# * DELETE /tipo_recursos/1
# * DELETE /tipo_recursos/1.json
  def destroy
    @tipo_recurso = TipoRecurso.find(params[:id])
    @tipo_recurso.destroy

    respond_to do |format|
      format.html { redirect_to tipo_recursos_url }
      format.json { head :no_content }
    end
  end

# ===  Accion existe
# Determina si existe un recurso de acuerdo a un nombre
# * GET /tipo_recursos/exist/nombre
  def existe
    @tipo_recurso = TipoRecurso.find_by_nombre(params[:nombre])
    if(@tipo_recurso)
      render :text => "true"
    else 
      render :text => "false"
    end
  end
end
