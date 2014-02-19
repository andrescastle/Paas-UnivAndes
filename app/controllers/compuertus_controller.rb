# = Controlador de Compuertas
# Esta clase implementa el controlador en el patron MVC para la tabla de compuertas.
# Una compuerta es una desición en el estandar BPMN
class CompuertusController < ApplicationController

  before_filter :authenticate_user!
  # ===  Accion Index
  # Lista todos las compuertas y las visualiza en una grilla
  # GET /compuertus
  # GET /compuertus.json
  def index
    @compuertus = Compuertu.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @compuertus }
    end
  end

  # ===  Accion Show
  # Presenta la informacion de una compuerta de acuerdo al id enviado
  # GET /compuertus/1
  # GET /compuertus/1.json
  def show
    @compuertu = Compuertu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @compuertu }
    end
  end

  # ===  Accion New
  # Presenta el formulario para la creacion de una compuerta
  # GET /compuertus/new
  # GET /compuertus/new.json
  def new
    @compuertu = Compuertu.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @compuertu }
    end
  end

  # ===  Accion edit
  # Presenta el formulario para la edicion de una compuerta
  # GET /compuertus/1/edit
  def edit
    @compuertu = Compuertu.find(params[:id])

    respond_to do |format|
      format.html { render layout: "actividads" }
      format.json { render json: @compuertu }
    end

  end

  # ===  Accion create
  # Crea una compuerta de acuerdo a los datos enviados en el formulario de creacion
  # POST /compuertus
  # POST /compuertus.json
  def create
    @compuertu = Compuertu.new(params[:compuertu])

    @nodo = MyJsTree.new(
        :parent_id => params[:nodo_padre],
        :position => params[:posicion],
        :type => params[:nodo_tipo],
        :title => params[:nodo_titulo],
        :plantilla_id => @compuertu.plantilla_id,
        :proceso_id => @compuertu.proceso_id,
        :left => 0,
        :right => 0,
        :level => 0
    )

    if @nodo.save
        @compuertu.my_js_tree_id=MyJsTree.last().id
        if @compuertu.save
          render :text => "true";

        else
          render :text => "false"
        end
      #redirect_to request.protocol + request.host_with_port + "/plantillas/" + @compuertu.plantilla_id.to_s()

   else
     render :text => "false"
      #respond_to do |format|
       # format.html { render action: "new" }
       # format.json { render json: @compuertu.errors, status: :unprocessable_entity }
      #end
    end
  end

  # ===  Accion update
  # Actualiza una compuerta de acuerdo a los datos enviados en el formulario de edicion
  # PUT /compuertus/1
  # PUT /compuertus/1.json
  def update
    @compuertu = Compuertu.find(params[:id])

    respond_to do |format|
      if @compuertu.update_attributes(params[:compuertu])
        format.html { render action: "edit", layout: "actividads" }
        format.json { head :no_content }
      else
        format.html { render action: "edit", layout: "actividads" }
        format.json { render json: @compuertu.errors, status: :unprocessable_entity }
      end
    end
  end

   def updateName
    @compuertu = Compuertu.find(params[:id])

   # respond_to do |format|
      if @compuertu.update_attribute("nombre", params[:nombre]) #update_attributes(params[:actividad])

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

  # ===  Accion destroy
  # Elimina una compuerta de acuerdo al id enviado
  # DELETE /compuertus/1
  # DELETE /compuertus/1.json
  def destroy
    @compuertu = Compuertu.find(params[:id])

    if( @compuertu.destroy)
      render :text => "true"
    else
      render :text => "false"
    end
  end
end
