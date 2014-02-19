# = Controlador de Plantillas
# Esta clase implementa el controlador en el patron MVC para la tabla de plantillas.
# Una plantilla es el diseño de un proceso utilizado en un proyecto.

class PlantillasController < ApplicationController
  # GET /plantillas
  # GET /plantillas.json

  before_filter :authenticate_user!
   before_filter :define_path


  def define_path
    @public_path = File.join(Rails.root.to_s, 'public')
    @uploads_url = '/uploads'
    @upload_path = File.join(@public_path, @uploads_url)
    @current_url = params[:dir] || @uploads_url
    @current_path = File.join(@public_path, @current_url)+ '/*'
  end

  # ===  Accion Index
  # Lista todos las plantillas y las visualiza en una grilla
  def index
    @plantillas = Plantilla.all.sort_by(&:created_at).reverse

    @tipo_plantillas = TipoPlantilla.all.uniq
    @var=1

    @plantilla = Plantilla.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plantillas }
    end
  end

  # ===  Accion Show
  # Presenta la informacion del diseño de una plantilla de acuerdo al id enviado
  # GET /plantillas/1
  # GET /plantillas/1.json
  def show
    @plantilla = Plantilla.includes(:actividads).find(params[:id])

    @tipo_recursos=TipoRecurso.all.uniq

    #@actividad = Actividad.first;
    #@compuertu = Compuertu.new

    @actividads = Actividad.find_all_by_plantilla_id(@plantilla.id)
    @compuertas = Compuertu.find_all_by_plantilla_id(@plantilla.id)

   #  @my_js_tree_id= MyJsTree.last.id+1

   # get_statistics @actividads, @compuertas

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plantilla }
    end
  end

  # ===  Accion New
  # Presenta el formulario para la creacion de una plantilla
  # GET /plantillas/new
  # GET /plantillas/new.json
  def new
    @plantilla = Plantilla.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plantilla }
    end
  end

  def get_statistics actividads, compuertus

    @numactividades = actividads.count
    @numcompuertas = compuertus.count
    @duracionest = 0
    @costoest = 0
    @numrecursos = 0

    @workvstime = "[0, 0]"
    @costvstime = "[0, 0]"
    @workvsresu = "[0, 0]"


    @i = 0
    actividads.each do |act|
     @i = @i + 1

      @workvstime += ",[#{@i.to_s()}, #{act.duracion.to_s()}]"

     if act.duracion != nil then
       @duracionest += act.duracion
      end

      @acttiporecs = ActividadTiporecurso.find_all_by_actividad_id(act.id)

      @cost = 0
      @qty = 0
      @acttiporecs.each do |acttiporec|
        @cost = @cost + acttiporec.tipo_recurso.cost * acttiporec.cantidad
        @qty = @qty +  acttiporec.cantidad
      end
      @numrecursos += @qty
      @costoest += @cost
      @costvstime += ",[#{@i.to_s()}, #{@cost.to_s()}]"

    end
  end
  # ===  Accion edit
  # Presenta el formulario para la edicion de una plantilla
  # GET /plantillas/1/edit
  def edit
    @plantilla = Plantilla.find(params[:id])
  end

  # ===  Accion create
  # Crea una plantilla de acuerdo a los datos enviados en el formulario de creacion
  # POST /plantillas
  # POST /plantillas.json
  def create
    @plantilla = Plantilla.new(params[:plantilla])

    respond_to do |format|
      if @plantilla.save

        @nodo = MyJsTree.new(
          :parent_id => 0,
          :position => 0,
          :type => 'root',
          :title => @plantilla.nombre,
          :plantilla_id => Plantilla.last().id,
          :left => 0,
          :right => 0,
          :level => 0
          )

        if @nodo.save
          @nodo1 = MyJsTree.new(
          :parent_id => MyJsTree.last().id,
          :position => 0,
          :type => 'evento_inicio',
          :title => 'Inicio',
          :plantilla_id => Plantilla.last().id,
          :left => 0,
          :right => 0,
          :level => 0
          )

          if @nodo1.save
            @evento=Evento.new(
              :nombre=>'Inicio',
              :descripcion=> '',
              :tipo=> '1',
              :plantilla_id=> Plantilla.last().id,
              :my_js_tree_id=> MyJsTree.last().id
            )
            if @evento.save
              
              @tipo_plantillas = TipoPlantilla.all.uniq
              @tipo_recursos=TipoRecurso.all.uniq
              @actividads = Actividad.find_all_by_plantilla_id(@plantilla.id)
              @compuertas = Compuertu.find_all_by_plantilla_id(@plantilla.id)

              @message = t('datos_guardados')

              format.html { render action: "show" }
              format.json { render json: @plantilla, status: :created, location: @plantilla }
            end
           end

        end


        
      else
        format.html { render action: "new" }
        format.json { render json: @plantilla.errors, status: :unprocessable_entity }
      end
    end
  end

  # ===  Accion update
  # Actualiza una plantilla de acuerdo a los datos enviados en el formulario de edicion
  # PUT /plantillas/1
  # PUT /plantillas/1.json
  def update
    @plantilla = Plantilla.find(params[:id])

    respond_to do |format|
      if @plantilla.update_attributes(params[:plantilla])
        format.html { redirect_to @plantilla, notice: 'Plantilla was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @plantilla.errors, status: :unprocessable_entity }
      end
    end
  end

  # ===  Accion destroy
  # Elimina una plantilla de acuerdo al id enviado
  # DELETE /plantillas/1
  # DELETE /plantillas/1.json
  def destroy
    @plantilla = Plantilla.find(params[:id])
    @plantilla.destroy

    respond_to do |format|
      format.html { redirect_to plantillas_url }
      format.json { head :no_content }
    end
  end

# ===  Accion existe
# Determina si existe un plantilla de acuerdo a un nombre
def existe
    @plantilla = Plantilla.find_by_nombre(params[:nombre])
    if(@plantilla)
      render :text => "true"
    else
      render :text => "false"
    end
  end

 protected

end
