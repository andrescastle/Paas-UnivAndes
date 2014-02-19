class ProyectoArtefactosController < ApplicationController
  # GET /proyecto_artefactos
  # GET /proyecto_artefactos.json
  before_filter :authenticate_user!
  def index

    @proyecto = Proyecto.find(params[:id])
    @assets_proyecto = getArtefactos @proyecto

    respond_to do |format|
      format.html { render 'index', :layout => 'actividads'}# show.html.erb
      format.json { render 'index', :layout => 'actividads'}
    end
  end

  def getArtefactos proyecto

    @assets_proyecto = Hash.new

    begin
      _url = ENV['root_razuna_api'] + "global/api2/folder.cfc?method=getfolders&api_key=" + ENV['admindavid_razuna_key']+"&__BDRETURNFORMAT=wddx"
      @wddx = WDDX.load(open(_url))

      @folders_found = @wddx.data.fields
      _folder_id = "0"
      _i = 0
      until _i >= @folders_found.count()  do

        _folder = @folders_found[_i]
        if(_folder[1] == proyecto.nombre)
          _folder_id = _folder[0]
        end
        _i += 1
      end

      _url = ENV['root_razuna_api'] + "global/api2/folder.cfc?method=getassets&api_key=" + ENV['admindavid_razuna_key']+"&folderid="+_folder_id+"&__BDRETURNFORMAT=wddx"
      @wddx = WDDX.load(open(_url))
      @assets_found = @wddx.data.fields

      _i=0
      until _i >= @assets_found.count()  do

        _asset = @assets_found[_i];

        @asset = Hash.new
        @asset[:id] = _asset[0];
        @asset[:file_name] = _asset[1];
        @asset[:folder_id] = _asset[2];
        @asset[:local_url_thumb] = _asset[19];

        @assets_proyecto[_i] = @asset

        _i += 1
      end
    rescue

    end

    return @assets_proyecto
  end

  # GET /proyecto_artefactos/1
  # GET /proyecto_artefactos/1.json
  def show
    @proyecto_artefacto = ProyectoArtefacto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @proyecto_artefacto }
    end
  end

  # GET /proyecto_artefactos/new
  # GET /proyecto_artefactos/new.json
  def new
    @proyecto_artefacto = ProyectoArtefacto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @proyecto_artefacto }
    end
  end

  # GET /proyecto_artefactos/1/edit
  def edit
    @proyecto_artefacto = ProyectoArtefacto.find(params[:id])
  end

  # POST /proyecto_artefactos
  # POST /proyecto_artefactos.json
  def create
    @proyecto_artefacto = ProyectoArtefacto.new(params[:proyecto_artefacto])

    respond_to do |format|
      if @proyecto_artefacto.save
        format.html { redirect_to @proyecto_artefacto, notice: 'Proyecto artefacto was successfully created.' }
        format.json { render json: @proyecto_artefacto, status: :created, location: @proyecto_artefacto }
      else
        format.html { render action: "new" }
        format.json { render json: @proyecto_artefacto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /proyecto_artefactos/1
  # PUT /proyecto_artefactos/1.json
  def update
    @proyecto_artefacto = ProyectoArtefacto.find(params[:id])

    respond_to do |format|
      if @proyecto_artefacto.update_attributes(params[:proyecto_artefacto])
        format.html { redirect_to @proyecto_artefacto, notice: 'Proyecto artefacto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @proyecto_artefacto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proyecto_artefactos/1
  # DELETE /proyecto_artefactos/1.json
  def destroy
    @proyecto_artefacto = ProyectoArtefacto.find(params[:id])
    @proyecto_artefacto.destroy

    respond_to do |format|
      format.html { redirect_to proyecto_artefactos_url }
      format.json { head :no_content }
    end
  end
end
