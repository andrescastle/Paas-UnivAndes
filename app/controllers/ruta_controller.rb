class RutaController < ApplicationController
  # GET /ruta
  # GET /ruta.json
  before_filter :authenticate_user!

  def index
    @ruta = Rutum.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ruta }
    end
  end

  # GET /ruta/1
  # GET /ruta/1.json
  def show
    @rutum = Rutum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rutum }
    end
  end

  # GET /ruta/new
  # GET /ruta/new.json
  def new
    @rutum = Rutum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rutum }
    end
  end

  # GET /ruta/1/edit
  def edit
    @rutum = Rutum.find(params[:id])
  end

  # POST /ruta
  # POST /ruta.json
  def create
    @rutum = Rutum.new(params[:rutum])

    @nodo = MyJsTree.new(
        :parent_id => params[:nodo_padre],
        :position => params[:posicion],
        :type => params[:nodo_tipo],
        :title => params[:nodo_titulo],
        :plantilla_id => @rutum.plantilla_id,
        :proceso_id => @rutum.proceso_id,
        :left => 0,
        :right => 0,
        :level => 0
    )

    if @nodo.save
          @rutum.my_js_tree_id=MyJsTree.last().id

      if @rutum.save
        render :text => "true";
       
        else
          render :text => "false"
        end
      #redirect_to request.protocol + request.host_with_port + "/plantillas/" + @compuertu.plantilla_id.to_s()

   else
     render :text => "false"
      #respond_to do |format|
       # format.html { render action: "new" }
      #  format.json { render json: @rutum.errors, status: :unprocessable_entity }
      #end
    end
  end
    

  # PUT /ruta/1
  # PUT /ruta/1.json
  def update
    @rutum = Rutum.find(params[:id])

    respond_to do |format|
      if @rutum.update_attributes(params[:rutum])
        format.html { redirect_to @rutum, notice: 'Rutum was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rutum.errors, status: :unprocessable_entity }
      end
    end
  end

  def updateName
    @rutum = Ruta.find(params[:id])

   # respond_to do |format|
      if @rutum.update_attribute("nombre", params[:nombre]) #update_attributes(params[:actividad])

       @my_js_tree = MyJsTree.find(params[:nodo_id])

       if @my_js_tree.update_attribute("title",params[:nombre])
          render :text => "true";
        else
          render :text => "false"
       end
     else
        render :text => "false"
      end
   # end
  end

  # DELETE /ruta/1
  # DELETE /ruta/1.json
  def destroy
    @rutum = Rutum.find(params[:id])
    if(@rutum.destroy)
      render :text => "true"
    else
      render :text => "false"
    end

  end
end
