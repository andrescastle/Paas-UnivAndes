class CompuertaDesicionsController < ApplicationController
  # GET /compuerta_desicions
  # GET /compuerta_desicions.json
  def index
    @compuerta_desicions = CompuertaDesicion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @compuerta_desicions }
    end
  end

  # GET /compuerta_desicions/1
  # GET /compuerta_desicions/1.json
  def show
    @compuerta_desicion = CompuertaDesicion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @compuerta_desicion }
    end
  end

  # GET /compuerta_desicions/new
  # GET /compuerta_desicions/new.json
  def new
    @compuerta_desicion = CompuertaDesicion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @compuerta_desicion }
    end
  end

  # GET /compuerta_desicions/1/edit
  def edit
    @compuerta_desicion = CompuertaDesicion.find(params[:id])
  end

  # POST /compuerta_desicions
  # POST /compuerta_desicions.json
  def create
    @compuerta_desicion = CompuertaDesicion.new(params[:compuerta_desicion])

    respond_to do |format|
      if @compuerta_desicion.save
        format.html { redirect_to @compuerta_desicion, notice: 'Compuerta desicion was successfully created.' }
        format.json { render json: @compuerta_desicion, status: :created, location: @compuerta_desicion }
      else
        format.html { render action: "new" }
        format.json { render json: @compuerta_desicion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /compuerta_desicions/1
  # PUT /compuerta_desicions/1.json
  def update
    @compuerta_desicion = CompuertaDesicion.find(params[:id])

    respond_to do |format|
      if @compuerta_desicion.update_attributes(params[:compuerta_desicion])
        format.html { redirect_to @compuerta_desicion, notice: 'Compuerta desicion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @compuerta_desicion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compuerta_desicions/1
  # DELETE /compuerta_desicions/1.json
  def destroy
    @compuerta_desicion = CompuertaDesicion.find(params[:id])
    @compuerta_desicion.destroy

    respond_to do |format|
      format.html { redirect_to compuerta_desicions_url }
      format.json { head :no_content }
    end
  end

  def options
    @compuerta = Compuertu.find(Tarea.find(params[:tarea_id]).compuerta_id)

    @myjstree = MyJsTree.find(@compuerta.my_js_tree_id)

    @options = Array.new
    partes = MyJsTree.find_all_by_parent_id(@myjstree.id)
    partes.each do |parte|
      @lacompuerta = CompuertaPreDesicion.find_by_compuerta_id_and_ruta_id_and_tarea_desicion_id(@myjstree.id, parte.id, params[:tarea_id])
      if @lacompuerta
        parte.type = @lacompuerta.elegida.to_s
        parte.proceso_id = @lacompuerta.id
      end
      @options.push parte
    end

    render :text => {:nombre => @compuerta.nombre, :compuerta_id => @myjstree.id, :descripcion => @compuerta.descripcion, :type => @myjstree.type, :options => @options}.to_json
  end
end
