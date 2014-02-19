class ArtefactosController < ApplicationController
  # GET /artefactos
  # GET /artefactos.json
  before_filter :authenticate_user!

  def index
    @artefactos = Artefacto.all


    @artefacto=Artefacto.new

    @depositos = Deposito.all
    @tipo_depositos = TipoDeposito.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @artefactos }
    end
  end

  # GET /artefactos/1
  # GET /artefactos/1.json
  def show
    #@artefacto = Artefacto.find(params[:id])
    @file_id = params[:id].split('-')[0]
    @folder_id = params[:id].split('-')[1]


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @artefacto }
    end
  end

  # GET /artefactos/new
  # GET /artefactos/new.json
  def new
    @artefacto = Artefacto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @artefacto }
    end
  end

  # GET /artefactos/1/edit
  def edit
    @artefacto = Artefacto.find(params[:id])
  end

  # POST /artefactos
  # POST /artefactos.json
  def create
    @artefacto = Artefacto.new(params[:artefacto])

    respond_to do |format|
      if @artefacto.save
        format.html { redirect_to @artefacto, notice: 'Artefacto was successfully created.' }
        format.json { render json: @artefacto, status: :created, location: @artefacto }
      else
        format.html { render action: "new" }
        format.json { render json: @artefacto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /artefactos/1
  # PUT /artefactos/1.json
  def update
    @artefacto = Artefacto.find(params[:id])

    respond_to do |format|
      if @artefacto.update_attributes(params[:artefacto])
        format.html { redirect_to @artefacto, notice: 'Artefacto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @artefacto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /artefactos/1
  # DELETE /artefactos/1.json
  def destroy
    @artefacto = Artefacto.find(params[:id])
    @artefacto.destroy

    respond_to do |format|
      format.html { redirect_to artefactos_url }
      format.json { head :no_content }
    end
  end

  def search_assets
    @palabra_clave = params[:palabra_clave]

    _url = ENV['root_razuna_api'] + "global/api2/search.cfc?method=searchassets&api_key=" + ENV['admindavid_razuna_key'] + "&searchfor=" + CGI::escape(@palabra_clave) +"&__BDRETURNFORMAT=wddx"
    @wddx = WDDX.load(open(_url))


    @assets_found = @wddx.data.fields
    @result = Hash.new
    _i=0
    until _i >= @assets_found.count()  do

      _asset = @assets_found[_i];

      @asset = Hash.new
      @asset[:id] = _asset[0];
      @asset[:file_name] = _asset[1];
      @asset[:folder_id] = _asset[2];
      @asset[:local_url_thumb] = _asset[17];

      @result[_i] = @asset

    _i += 1
    end

    render json: @result

  end

  # ===  Accion obtener session token de razuna
  def get_razuna_sessiontoken

	# Consultamos folder con el nombre
	url = 'http://pruebasdavid.virtual.uniandes.edu.co:8080/razuna/global/api/authentication.cfc?hostid=1'
	method = '&method=login'
	user = '&user=admindavid'
	pass = '&pass=123456'
	passhashed = '&passhashed=0'
	uri = URI(url + method + user + pass + passhashed)

	# FORMA DE ADQUIRIR EL SESSION TOKEN TODO: MEJORARLO
	tutti = open(url + method + user + pass + passhashed).read
	after = tutti.split('sessiontoken&gt;', 2).last
	token = after.split('&lt;/sessiontoken&gt', 2).first
	puts token + ";"
	
    render :text => token
  end
end
