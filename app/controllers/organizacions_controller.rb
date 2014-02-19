class OrganizacionsController < ApplicationController
  # GET /organizacions
  # GET /organizacions.json
  before_filter :authenticate_user!

  def index
    @organizacions = Organizacion.all.sort_by(&:created_at).reverse
    @organizacion=Organizacion.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @organizacions }
    end
  end

  # GET /organizacions/1
  # GET /organizacions/1.json
  def show
    @organizacion = Organizacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @organizacion }
    end
  end

  # GET /organizacions/new
  # GET /organizacions/new.json
  def new
    @organizacion = Organizacion.new
    @usuario = Usuario.new


    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @organizacion }
    end
  end

  # GET /organizacions/1/edit
  def edit
    @organizacion = Organizacion.find(params[:id])
  end

  # POST /organizacions
  # POST /organizacions.json
  def create
    _data_usr = params[:usuario]
    _data_org = params[:organizacion]
    respond_to do |format|
      @organizacion = Organizacion.new(_data_org)
      if @organizacion.save

        create_representante @organizacion.id, _data_usr

        @organizacion = Organizacion.new
        @organizacions = Organizacion.all
        @message = t('datos_guardados')


        format.html { render action: "index" }
        format.json { render json: @organizacion }
      
        #format.html { redirect_to @organizacion, notice: 'Organizacion was successfully created.' }
        #format.json { render json: @organizacion, status: :created, location: @organizacion }
      else
        format.html { render action: "new" }
        format.json { render json: @organizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_representante organizacion_id, data

    @usuario = Usuario.new(data)

    _data_usr = Hash.new
    _data_usr[:email] = data[:email]
    _data_usr[:password] = data[:password]

    @user = User.new(_data_usr)

    @usuario.organizacion_id=organizacion_id

      if @usuario.save!

        @user.id = @usuario.id
        @user.save!

        @user_rol = RolesUsers.new(
            :user_id => @user.id,
            :role_id => 1
        )

        @user_rol.save!

       # @usuario_rol = RolesUsuarios.new(
       #     :usuario_id => @usuario.id,
       #     :role_id => 2
       # )

       # @usuario_rol.save!

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
      end
  end

  # PUT /organizacions/1
  # PUT /organizacions/1.json
  def update
    @organizacion = Organizacion.find(params[:id])

    respond_to do |format|
      if @organizacion.update_attributes(params[:organizacion])
        format.html { redirect_to @organizacion, notice: 'Organizacion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @organizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizacions/1
  # DELETE /organizacions/1.json
  def destroy
    @organizacion = Organizacion.find(params[:id])
    @organizacion.destroy

    respond_to do |format|
      format.html { redirect_to organizacions_url }
      format.json { head :no_content }
    end
  end
  
	# ===  Accion existe
	# Determina si existe una organizacion de acuerdo a un nombre
	def existe
	  @organizacion = Organizacion.find_by_nombre(params[:nombre])
	  if(@organizacion)
		render :text => "true"
	  else
		render :text => "false"
	  end
	end 
	
	# ===  Accion existe
	# Determina si existe una organizacion de acuerdo a un nit
	def existenit
	  @organizacion = Organizacion.find_by_nit(params[:nit])
	  if(@organizacion)
		render :text => "true"
	  else
		render :text => "false"
	  end
  end

  # ===  Accion existe
  # Determina si existe un representante con el email dado
  def existerepresentante
    @user = Usuario.find_by_email(params[:representante])
    if(@user)
      render :text => "true"
    else
      render :text => "false"
    end
  end

  # ===  Accion existe
  # Determina si existe un representante con el email dado
  def unicorepresentante
    @user = Organizacion.find_by_representante(params[:representante])
    if(@user)
      render :text => "true"
    else
      render :text => "false"
    end
  end
end
