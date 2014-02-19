class ProyectoOrganizacionsController < ApplicationController
  # GET /proyecto_organizacions
  # GET /proyecto_organizacions.json
  before_filter :authenticate_user!

  def index
    @proyecto_organizacions = ProyectoOrganizacion.all

    @proyecto_organizacion = ProyectoOrganizacion.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @proyecto_organizacions }
    end
  end

  # GET /proyecto_organizacions/1
  # GET /proyecto_organizacions/1.json
  def show
    @proyecto_organizacion = ProyectoOrganizacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @proyecto_organizacion }
    end
  end

  # GET /proyecto_organizacions/new
  # GET /proyecto_organizacions/new.json
  def new
    @proyecto_organizacion = ProyectoOrganizacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @proyecto_organizacion }
    end
  end

  # GET /proyecto_organizacions/1/edit
  def edit
    @proyecto_organizacion = ProyectoOrganizacion.find(params[:id])
  end

  # POST /proyecto_organizacions
  # POST /proyecto_organizacions.json
  def create
    @id_proyecto = params[:proyecto_id]
    @organizacions = params[:selected_organizacion]

    @proyecto = Proyecto.find(@id_proyecto)

    @sucess = false;

    @proyecto_organizacions = ProyectoOrganizacion.find_all_by_proyecto_id(@id_proyecto)
    if(@proyecto_organizacions != nil)
      @proyecto_organizacions.each do |proyecto_organizacion|
        proyecto_organizacion.delete()
      end
    end

    if(@organizacions != nil)

    @organizacions.each do |organizacion_id|
    @proyecto_organizacion = ProyectoOrganizacion.new(
          :organizacion_id => organizacion_id,
          :proyecto_id => @id_proyecto)

        if(@proyecto_organizacion.save)
          @sucess = true;
        else
          break;
        end
    end

    if @sucess
        redirect_to request.protocol + request.host_with_port + "/proyectos/#{@id_proyecto}/configu"
    else
        respond_to do |format|
        format.html { render action: "new" }
        format.json { render json: @proyecto_organizacion.errors, status: :unprocessable_entity }
      end
    end

    else
      redirect_to request.protocol + request.host_with_port + "/proyectos/#{@id_proyecto}/configu"
    end

  end

  # PUT /proyecto_organizacions/1
  # PUT /proyecto_organizacions/1.json
  def update
    @proyecto_organizacion = ProyectoOrganizacion.find(params[:id])

    respond_to do |format|
      if @proyecto_organizacion.update_attributes(params[:proyecto_organizacion])
        format.html { redirect_to @proyecto_organizacion, notice: 'Proyecto organizacion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @proyecto_organizacion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proyecto_organizacions/1
  # DELETE /proyecto_organizacions/1.json
  def destroy
    @proyecto_organizacion = ProyectoOrganizacion.find(params[:id])
    @proyecto_organizacion.destroy

    respond_to do |format|
      format.html { redirect_to proyecto_organizacions_url }
      format.json { head :no_content }
    end
  end

  def get_tipo_organizacions

    @data_for_select2 = TipoOrganizacion.all

    @c= params[:callback]

    @tam=@data_for_select2.length
    @i=1
    @data = @c+"({"+"\""
    @data_for_select2.each do |select|

      @data  = @data+select.id.to_s+"\""+":"+"\""+select.name+"\""

      if @tam!=@i
        @data=@data+","+"\""
      else
        @data=@data+"})"
      end
      @i=@i+1
    end

    render :json => @data
  end

  def get_organizacions

    @comilla='"';
    @data_for_select1 = params[:tipo_organizacion_id]

    @data_for_select2 = Organizacion.where(:tipo_organizacion_id => @data_for_select1).all
    @c= params[:callback]

    @tam=@data_for_select2.length
    @i=1
    if @tam!=0

      @data = @c+"({"+"\""

      @data_for_select2.each do |select|

      @data  = @data+select.id.to_s+"\""+":"+"\""+select.nombre+"\""

      if @tam!=@i
        @data=@data+","+"\""
      else
        @data=@data+"})"
      end
        @i=@i+1
    end
    else
      @data=""
    end

    render :json => @data
  end

end
