# = Controlador de actividades
# Esta clase implementa el controlador en el patron MVC para la tabla de actividades.
# Una actividad es una tarea de usuario en el estandar BPMN.


class ActividadsController < ApplicationController
  # ===  Accion Index
  # Lista todos las actividades y las visualiza en una grilla
  # GET /actividads
  # GET /actividads.json
  before_filter :authenticate_user!

  def index
    @actividads = Actividad.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @actividads }
    end
  end

  # ===  Accion Show
  # Presenta la informacion de un actividad de acuerdo al id enviado
  # GET /actividads/1
  # GET /actividads/1.json
  def show
    @actividad = Actividad.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @actividad }
    end
  end

  # ===  Accion New
  # Presenta el formulario para la creacion de una actividad
  # GET /actividads/new
  # GET /actividads/new.json
  def new
    @actividad = Actividad.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @actividad }
    end
  end

  # ===  Accion edit
  # Presenta el formulario para la edicion de una actividad
  # GET /actividads/1/edit
  def edit
    @actividad = Actividad.find(params[:id])

    @actividad_tiporecursos = ActividadTiporecurso.find_all_by_actividad_id( params[:id])

    @actividad_tiporecursos_material = []
    @actividad_tiporecursos_humano = []

    @actividad_tiporecursos.each do |actividad_tipo_recurso|
      if actividad_tipo_recurso.tipo_recurso.unit == 1
        @actividad_tiporecursos_humano.push(actividad_tipo_recurso)
      end
    end

    @actividad_tiporecursos.each do |actividad_tipo_recurso|
      if actividad_tipo_recurso.tipo_recurso.unit == 2
        @actividad_tiporecursos_material.push(actividad_tipo_recurso)
      end
    end

    @actividad_tiporecurso =  ActividadTiporecurso.new
    @tipo_recursos_material = TipoRecurso.find_all_by_unit(2)
    @tipo_recursos_humano = TipoRecurso.find_all_by_unit(1)

    @actividad_tipoartefactos = ActividadTipoartefacto.find_all_by_actividad_id( params[:id])
    @actividad_tipoartefacto =  ActividadTipoartefacto.new
    @tipo_artefactos = TipoArtefacto.all

    @actividad_roles = ActividadRol.find_all_by_actividad_id( params[:id])
    @actividad_rol =  ActividadRol.new
    @roles = Rol.all

    @actividad_revision = ActividadRevision.new
    @actividad_revisiones = ActividadRevision.find_all_by_actividad_id( params[:id], :order => "turno")

    if(!@actividad.num_instancias)
      @actividad.num_instancias = 1
    end

  end

  # ===  Accion create
  # Crea una actividad de acuerdo a los datos enviados en el formulario de creación
  # POST /actividads
  # POST /actividads.json
  def create
    mactividad = Actividad.new(params[:actividad])
    mactividad.nombre = params[:nodo_titulo]

    actividad_exist = false

    if(params[:actividad_id].to_i.to_s == params[:actividad_id])

      actividad_exist = true
      mactividad = Actividad.find(params[:actividad_id])

      @actividad = Actividad.new(
        :nombre => mactividad.nombre,
        :descripcion => mactividad.descripcion,
        :modoejecucion => mactividad.modoejecucion,
        :duracion => mactividad.duracion,
        :plantilla_id => mactividad.plantilla_id,
        :proceso_id =>  mactividad.proceso_id,
        :num_instancias => mactividad.num_instancias,
        :responsable_id => mactividad.responsable_id,
        :horas_estimadas => mactividad.horas_estimadas,
        :tipocontrol => mactividad.tipocontrol,
        :modo_revision => mactividad.modo_revision
      )

    else
      @actividad = mactividad
    end

    @nodo = MyJsTree.new(
        :parent_id => params[:nodo_padre],
        :position => params[:posicion],
        :type => params[:nodo_tipo],
        :title => @actividad.nombre,
        :plantilla_id => @actividad.plantilla_id,
        :proceso_id => @actividad.proceso_id,
        :left => 0,
        :right => 0,
        :level => 0
    )

    if @nodo.save
      @actividad.my_js_tree_id=MyJsTree.last().id

      if  @actividad.save
            render :text => "true";

        if(actividad_exist)

          tiporecursos = ActividadTiporecurso.find_all_by_actividad_id(mactividad.id)
          tiporecursos.each do |act_tiporecurso|
            record = ActividadTiporecurso.new(
                :actividad_id => @actividad.id,
                :tipo_recurso_id => act_tiporecurso.tipo_recurso_id
             )
            record.save!
          end

          tipoartefactos = ActividadTipoartefacto.find_all_by_actividad_id(mactividad.id)
          tipoartefactos.each do |act_tipoartefacto|
            record = ActividadTipoartefacto.new(
                :actividad_id => @actividad.id,
                :tipo_artefacto_id => act_tipoartefacto.tipo_artefacto_id,
                :modo => act_tipoartefacto.modo
            )
            record.save!
          end

          revisiones = ActividadRevision.find_all_by_actividad_id(mactividad.id)
          revisiones.each do |act_revisions|
            record = ActividadRevision.new(
                :actividad_id => @actividad.id,
                :tipo_recurso_id => act_revisions.tipo_recurso_id,
                :nombre => act_revisions.nombre
            )
            record.save!
          end
        end
      else
            @nodo.delete
            render :text => "false"
      end
    else
      render :text => "false"
    end
  end

  # ===  Accion update
  # Actualiza una actividad de acuerdo a los datos enviados en el formulario de edicion
  # PUT /actividads/1
  # PUT /actividads/1.json
  def update
    @actividad = Actividad.find(params[:id])

     if @actividad.update_attributes(params[:actividad])

       @actividad_tiporecursos = ActividadTiporecurso.find_all_by_actividad_id( params[:id])

       @actividad_tiporecursos_material = []
       @actividad_tiporecursos_humano = []

       @actividad_tiporecursos.each do |actividad_tipo_recurso|
         if actividad_tipo_recurso.tipo_recurso.unit == 1
           @actividad_tiporecursos_humano.push(actividad_tipo_recurso)
         end
       end

       @actividad_tiporecursos.each do |actividad_tipo_recurso|
         if actividad_tipo_recurso.tipo_recurso.unit == 2
           @actividad_tiporecursos_material.push(actividad_tipo_recurso)
         end
       end

       @actividad_tiporecurso =  ActividadTiporecurso.new
       @tipo_recursos_material = TipoRecurso.find_all_by_unit(2)
       @tipo_recursos_humano = TipoRecurso.find_all_by_unit(1)

       @actividad_tipoartefactos = ActividadTipoartefacto.find_all_by_actividad_id( params[:id])
       @actividad_tipoartefacto =  ActividadTipoartefacto.new
       @tipo_artefactos = TipoArtefacto.all

       @actividad_roles = ActividadRol.find_all_by_actividad_id( params[:id])
       @actividad_rol =  ActividadRol.new
       @roles = Rol.all

       @actividad_revision = ActividadRevision.new
       @actividad_revisiones = ActividadRevision.find_all_by_actividad_id( params[:id])

       @message = t('datos_guardados')

         respond_to do |format|
          format.html { render action: "edit" }
           format.json { head :no_content }
         end
     else
      
        respond_to do |format|
          format.html { render action: "edit" }
          format.json { render json: @actividad.errors, status: :unprocessable_entity }
        end
    end

  end

   def updateName
    @actividad = Actividad.find(params[:id])

   # respond_to do |format|
      if @actividad.update_attribute("nombre", params[:nombre]) #update_attributes(params[:actividad])

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
  # Elimina una actividad de acuerdo al id enviado
  # DELETE /actividads/1
  # DELETE /actividads/1.json
  def destroy
    @actividad = Actividad.find(params[:id])

    @tareas = Tarea.find_all_by_actividad_id(:id)
    @tareas.each do |tarea|
      tarea.destroy
    end

    if( @actividad.destroy)
      render :text => "true";
    else
      render :text => "false"
    end
  end


  # ===  Accion existe
# Determina si existe una actividad de acuerdo a un nombre en esa plantilla
def existe
    @actividad = Actividad.where("nombre = ? AND plantilla = ?",params[:nombre],params[:plantilla])
   #   Plantilla.find_by_nombre(params[:nombre])

   if(@actividad)
      render :text => "true"
    else
      render :text => "false"
    end
end

  def actividades_proceso
    @actividades = Actividad.find_all_by_proceso_id(params[:id])


    @tam=@actividades.length
    @i=1
    @data = "{"+"\""
    @actividades.each do |actividad|

      @data  = @data+actividad.id.to_s+"\""+":"+"\""+actividad.nombre+"\""

      if @tam!=@i
        @data=@data+","+"\""
      else
        @data=@data+"}"
      end
      @i=@i+1
    end

    render :text => @data
  end

  def turnos

    texto = ""
    params[:datos].each do |unparam|
      partido = ""
      partido = unparam.split(/_/)
      ar_id = partido[1]
      tipo_rec = partido[3]
      turno = partido[5]

      @actividad_revisiones = ActividadRevision.find(ar_id)
      @actividad_revisiones.turno = turno

      @actividad_revisiones.save


    end

    render :text => "true"

  end



end

