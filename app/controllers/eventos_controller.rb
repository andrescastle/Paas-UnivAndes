class EventosController < ApplicationController
  before_filter :authenticate_user!

  # GET /eventos
  # GET /eventos.json
  def index
    @eventos = Evento.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @eventos }
    end
  end

  # GET /eventos/1
  # GET /eventos/1.json
  def show
    @evento = Evento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @evento }
    end
  end

  # GET /eventos/new
  # GET /eventos/new.json
  def new
    @evento = Evento.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @evento }
    end
  end

  # GET /eventos/1/edit
  def edit
    @evento = Evento.find(params[:id])
  end

  # POST /eventos
  # POST /eventos.json
  def create
    @evento = Evento.new(params[:evento])

    @nodo = MyJsTree.new(
        :parent_id => params[:nodo_padre],
        :position => params[:posicion],
        :type => params[:nodo_tipo],
        :title => params[:nodo_titulo],
        :plantilla_id => @evento.plantilla_id,
        :proceso_id => @evento.proceso_id,
        :left => 0,
        :right => 0,
        :level => 0
    )

    if @nodo.save
          @evento.my_js_tree_id=MyJsTree.last().id

      if @evento.save
           render :text => "true";
       
        else
          render :text => "false"
        end
      #redirect_to request.protocol + request.host_with_port + "/plantillas/" + @compuertu.plantilla_id.to_s()

   else
     render :text => "false"
      #respond_to do |format|
       # format.html { render action: "new" }
      #  format.json { render json: @evento.errors, status: :unprocessable_entity }
      #end
    end
  end
   


  # PUT /eventos/1
  # PUT /eventos/1.json
  def update
    @evento = Evento.find(params[:id])

    respond_to do |format|
      if @evento.update_attributes(params[:evento])
        format.html { redirect_to @evento, notice: 'Evento was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  def updateName
    @evento = Evento.find(params[:id])

   # respond_to do |format|
      if @evento.update_attribute("nombre", params[:nombre]) #update_attributes(params[:actividad])

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

  # DELETE /eventos/1
  # DELETE /eventos/1.json
  def destroy
    @evento = Evento.find(params[:id])

    if( @evento.destroy)
      render :text => "true"
    else
      render :text => "false"
    end
  end
end
