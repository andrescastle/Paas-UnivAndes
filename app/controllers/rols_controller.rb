class RolsController < ApplicationController
  # GET /rols
  # GET /rols.json
  before_filter :authenticate_user!

  def index
    @tipo_recursos = TipoRecurso.where(:unit => '1').all.sort_by(&:created_at).reverse
    @var=1
    @tipo_recurso = TipoRecurso.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tipo_recurso }
    end
  end

  # GET /rols/1
  # GET /rols/1.json
  def show
   # redirect_to(rols_path,:notice => "Sorry, you can’t edit this tweet")
    @rol = Rol.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rol }
    end
  end

  # GET /rols/new
  # GET /rols/new.json
  def new
    @rol = Rol.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rol }
    end
  end

  # GET /rols/1/edit
  def edit
    @rol = Rol.find(params[:id])
  end

  # POST /rols
  # POST /rols.json
  def create
    @rol = Rol.new(params[:rol])
    @rols = Rol.all

    respond_to do |format|
      if @rol.save
        @message = t('datos_guardados')
        format.html { render  action: "index" }
        format.json { render json: @rol }
      else
        format.html { render action: "new" }
        format.json { render json: @rol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rols/1
  # PUT /rols/1.json
  def update
    @rol = Rol.find(params[:id])

    respond_to do |format|
      if @rol.update_attributes(params[:rol])
        format.html { redirect_to @rol, notice: 'Rol was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rols/1
  # DELETE /rols/1.json
  def destroy
    @rol = Rol.find(params[:id])
    @rol.destroy

    respond_to do |format|
      format.html { redirect_to rols_url }
      format.json { head :no_content }
    end
  end
  
	# ===  Accion existe
	# Determina si existe un proyecto de acuerdo a un nombre
	def existe
	  @rol = Rol.find_by_nombre(params[:nombre])
	  if(@rol)
		render :text => "true"
	  else
		render :text => "false"
	  end
	end
end

