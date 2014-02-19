class TipoArtefactosController < ApplicationController
  # GET /tipo_artefactos
  # GET /tipo_artefactos.json
  before_filter :authenticate_user!

  def index
    @tipo_artefactos = TipoArtefacto.all.sort_by(&:created_at).reverse
    @var=1
    @tipo_artefacto = TipoArtefacto.new
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tipo_artefactos }
    end
  end

  # GET /tipo_artefactos/1
  # GET /tipo_artefactos/1.json
  def show
    @tipo_artefacto = TipoArtefacto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tipo_artefacto }
    end
  end

  # GET /tipo_artefactos/new
  # GET /tipo_artefactos/new.json
  def new
    @tipo_artefacto = TipoArtefacto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tipo_artefacto }
    end
  end

  # GET /tipo_artefactos/1/edit
  def edit
    @tipo_artefacto = TipoArtefacto.find(params[:id])
  end

  # POST /tipo_artefactos
  # POST /tipo_artefactos.json
  def create

    @tipo_artefacto = TipoArtefacto.new(params[:tipo_artefacto])

    respond_to do |format|
      if @tipo_artefacto.save

        begin
          @wddx = WDDX.load(open(ENV['root_razuna_api'] + "global/api2/label.cfc?method=setlabel&api_key=" + ENV['admindavid_razuna_key'] + "&label_text=" + CGI::escape(@tipo_artefacto.nombre) +"&__BDRETURNFORMAT=wddx"))
        rescue
        end

        @tipo_artefacto = TipoArtefacto.new
        @tipo_artefactos = TipoArtefacto.all

        @message = t('datos_guardados')
        format.html { render action: "index" }
        format.json { render json: @tipo_artefactos }
      else
        format.html { render action: "new" }
        format.json { render json: @tipo_artefacto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tipo_artefactos/1
  # PUT /tipo_artefactos/1.json
  def update
    @tipo_artefacto = TipoArtefacto.find(params[:id])

    respond_to do |format|
      if @tipo_artefacto.update_attributes(params[:tipo_artefacto])
        format.html { redirect_to @tipo_artefacto, notice: 'Tipo artefacto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tipo_artefacto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tipo_artefactos/1
  # DELETE /tipo_artefactos/1.json
  def destroy
    @tipo_artefacto = TipoArtefacto.find(params[:id])
    @tipo_artefacto.destroy

    respond_to do |format|
      format.html { redirect_to tipo_artefactos_url }
      format.json { head :no_content }
    end
  end

  # ===  Accion existe
  # Determina si existe un tipo de artefacto de acuerdo a un nombre
  # * GET /tipo_plantilla/exist/nombre
  def existe
    @tipo_artefacto = TipoArtefacto.find_by_nombre(params[:nombre])
    if(@tipo_artefacto)
      render :text => "true"
    else
      render :text => "false"
    end
  end
end



