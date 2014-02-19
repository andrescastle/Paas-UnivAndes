class ActividadRolsController < ApplicationController
  # GET /actividad_rols
  # GET /actividad_rols.json
  before_filter :authenticate_user!

  def index
    @actividad_rols = ActividadRol.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @actividad_rols }
    end
  end

  # GET /actividad_rols/1
  # GET /actividad_rols/1.json
  def show
    @actividad_rol = ActividadRol.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @actividad_rol }
    end
  end

  # GET /actividad_rols/new
  # GET /actividad_rols/new.json
  def new
    @actividad_rol = ActividadRol.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @actividad_rol }
    end
  end

  # GET /actividad_rols/1/edit
  def edit
    @actividad_rol = ActividadRol.find(params[:id])
  end

  # POST /actividad_rols
  # POST /actividad_rols.json
  def create
    @rol_id = Rol.find_by_nombre(params[:rol_name]).id;

    @actividad_rol = ActividadRol.find_by_rol_id_and_actividad_id(@rol_id,params[:actividad_id]);

    if( @actividad_rol == nil)

      @actividad_rol = ActividadRol.new(
          :rol_id => @rol_id,
          :actividad_id => params[:actividad_id]
      )

    end

    if @actividad_rol.save

      redirect_to request.protocol + request.host_with_port + "/actividads/" + params[:actividad_id] + "/edit"

    else
      respond_to do |format|
        format.html { render action: "edit" }
        format.json { render json: @actividad_rol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /actividad_rols/1
  # PUT /actividad_rols/1.json
  def update
    @actividad_rol = ActividadRol.find(params[:id])

    respond_to do |format|
      if @actividad_rol.update_attributes(params[:actividad_rol])
        format.html { redirect_to @actividad_rol, notice: 'Actividad rol was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @actividad_rol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actividad_rols/1
  # DELETE /actividad_rols/1.json
  def destroy
    @actividad_rol = ActividadRol.find(params[:id])
    @actividad_rol.destroy

    respond_to do |format|
      format.html { redirect_to actividad_rols_url }
      format.json { head :no_content }
    end
  end
end
