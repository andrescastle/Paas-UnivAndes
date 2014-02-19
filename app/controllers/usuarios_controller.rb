class UsuariosController < ApplicationController

  #before_filter :authenticate_user!

  # GET /usuarios
  # GET /usuarios.json
  def index
    @usuarios = Usuario.find_all_by_organizacion_id(Usuario.find_by_id(current_user.id).organizacion_id)
    @usuarios = @usuarios.sort_by(&:nombre)
    @usuario = Usuario.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @usuarios }
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.json
  def show
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @usuario }
    end
  end

  # GET /usuarios/new
  # GET /usuarios/new.json
  def new
    @usuario = Usuario.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = Usuario.find(params[:id])
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(params[:usuario])
    @usuario.organizacion_id=Usuario.find_by_id(current_user.id).organizacion_id

    _data_usr = Hash.new
    _data_usr[:email] = @usuario.email
    _data_usr[:password] = @usuario.password

    @user=User.new(_data_usr)

    respond_to do |format|
      if @usuario.save!
          @user.id = @usuario.id
          @user.save!

          params[:roles].each do |rol|
            rol1 = RolesUsers.new(:role_id => rol, :user_id => @usuario.id)
            rol1.save!
          end

          begin
          _url = ENV['root_razuna_api'] + "global/api2/user.cfc?method=add&api_key=" + ENV['admindavid_razuna_key'] +
            "&user_first_name="+ URI::encode(@usuario.nombre) +
            "&user_last_name="+ URI::encode(@usuario.apellidos) +
            "&user_email="+ URI::encode(@usuario.email) +
            "&user_name=" + URI::encode(@usuario.email) +
            "&user_pass="+ URI::encode(@usuario.password) +
            "&user_active=T"

            @wddx = WDDX.load(open(_url))
          rescue
          end

        @usuario = Usuario.new
        @usuarios = Usuario.find_all_by_organizacion_id(Usuario.find_by_id(current_user.id).organizacion_id)
        @usuarios = @usuarios.sort_by(&:nombre)

        @message = t('datos_guardados')
        format.html { render action: "index" }
        format.json { render json: @usuario }
      else
        format.html { render action: "new" }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.json
  def update
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
        format.html { redirect_to @usuario, notice: 'Usuario was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.json
  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy

    respond_to do |format|
      format.html { redirect_to usuarios_url }
      format.json { head :no_content }
    end
  end

  # ===  Accion existe
  # Determina si existe un login de usuario
  # * GET /usuarios/existe/login
  def existe
    @usuario = Usuario.find_by_email(params[:nombre])
    if(@usuario)
      render :text => "true"
    else
      render :text => "false"
    end
  end

  # ===  Accion password son iguales
  def password_iguales
    if(params[:password] == params[:password_confirm])
      render :text => "false"
    else
      render :text => "true"
    end
  end

end

