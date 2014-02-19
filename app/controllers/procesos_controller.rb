require 'rbconfig'
require 'fileutils'

include Config
include ProcesosHelper

class ProcesosController < ApplicationController
  # GET /procesos
  # GET /procesos.json
  before_filter :authenticate_user!


  def index
    @procesos = Proceso.all.sort_by(&:created_at).reverse

    @proceso = Proceso.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @procesos }
    end
  end



  # GET /procesos/1
  # GET /procesos/1.json
  def show
    @proceso = Proceso.find(params[:id])
    @proyecto=Proyecto.find_by_id(@proceso.proyecto_id)

    @actividades= @proceso.actividads.all

    @tipo_recursos=TipoRecurso.all.uniq

    respond_to do |format|
      format.html { render :layout => 'proyectos1'}# show.html.erb
      format.json { render json: @proceso }
    end
  end

  def Reportes
    generar_reporte(params[:id_proceso])
    render :template => 'procesos/Overview', :layout => 'reportes'
  end

  def reporte_recursos (f2)

  end

  def Overview

   render :template => 'procesos/Overview', :layout => 'reportes'
  end
  def Status
    render :template => 'procesos/Status', :layout => 'reportes'
  end
  def ResourceGraph
    render :template => 'procesos/ResourceGraph', :layout => 'reportes'
  end
  def resourcesM
    render :template => 'procesos/resourcesM', :layout => 'reportes'
  end
  def Workpackage1
    render :template => 'procesos/Work package 1', :layout => 'reportes'
  end
  def Workpackage2
    render :template => 'procesos/Work package 2', :layout => 'reportes'
  end
  def ContactList
    render :template => 'procesos/ContactList', :layout => 'reportes'
  end
  def Deliveries
    render :template => 'procesos/Deliveries', :layout => 'reportes'
  end
  def Development
    render :template => 'procesos/Development', :layout => 'reportes'
  end
  def BurndownChart
    render :template => 'procesos/BurndownChart', :layout => 'reportes'
  end
  # GET /procesos/new
  # GET /procesos/new.json

  def change_tipoPlantilla #Funcion Ajax que modificara el combo de plantillas
    @obj_proceso = Proceso.new()
    @list_plantillas = Plantillas.find(:all,:conditions=>{:tipo_plantilla_id=>params[:tipo_plantilla_id_id].to_i})

    #change_companies.rjs
    page.replace_html("list_plantillas",:partial=>"select_plantillas")
  end


   def getTipoPlantilla

    @data_for_select2 = TipoPlantilla.all

    #render :json =>"{"+@comilla+"1"+@comilla+":"+@comilla+"Alto Orinoco"+@comilla+","+@comilla+"2"+@comilla+":"+@comilla+"Huachamacare"+@comilla+"}"
    @c= params[:callback]

    @tam=@data_for_select2.length
    @i=1
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
    #3143216669

  #  @data=@c+"({"+"\""+"1"+"\""+":"+"\""+"Hola"+"\""+","+"\""+"3"+"\""+":"+"\""+"Chao"+"\""+"})"
    #@data=TipoPlantilla.all.map{|p| [p.id.to_s,p.id.to_s+":"+p.nombre] }
    #render :json => @data_for_select2.map{|c| [c.id.to_s(), c.nombre] }
    render :text => @data

  end


  def getdata

    @comilla='"';
    @data_for_select1 = params[:tipo_plantilla]

    @data_for_select2 = Plantilla.where(:tipo_plantilla_id => @data_for_select1).all
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

  def new

    @proceso = Proceso.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @proceso }
    end
  end

  # GET /procesos/1/edit
  def edit
    @proceso = Proceso.find(params[:id])
  end

  # POST /procesos
  # POST /procesos.json
  def create
    @proceso = Proceso.new(params[:proceso])
    @proceso.proyecto_id=params[:proyecto_id]
    @proceso.tipo_plantilla_id=params[:proceso_tipo_plantilla]
    @id_plantilla = params[:plantilla]

    @proyecto = Proyecto.find(params[:proyecto_id])
    @procesos= Proceso.find_all_by_proyecto_id(:proyecto_id)

    respond_to do |format|
      if @proceso.save

        clonar_plantilla( @id_plantilla, @proceso.id )

        format.html { redirect_to @proceso, notice: 'Proceso was successfully created.' }
        format.json { render json: @proceso, status: :created, location: @proceso }
      else
        format.html { render action: "new" }
        format.json { render json: @proceso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /procesos/1
  # PUT /procesos/1.json
  def update
    @proceso = Proceso.find(params[:id])

    respond_to do |format|
      if @proceso.update_attributes(params[:proceso])
        format.html { redirect_to @proceso, notice: 'Proceso was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @proceso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /procesos/1
  # DELETE /procesos/1.json
  def destroy
    @proceso = Proceso.find(params[:id])
    @proceso.destroy

    respond_to do |format|
      format.html { redirect_to procesos_url }
      format.json { head :no_content }
    end
  end

  def clonar_plantilla(id_plantilla, id_proceso)

    @id_plantilla = id_plantilla
    @id_proceso = id_proceso

    @plantilla = Plantilla.find(@id_plantilla)

      @my_js_all_tress = Array.new
      @my_js_all_oldnew = Hash.new

      @my_js_tree_origen = MyJsTree.find_by_plantilla_id(@plantilla.id)
      @my_js_tree = MyJsTree.new(
          :parent_id => 0,
          :position => @my_js_tree_origen.position,
          :left => @my_js_tree_origen.left,
          :right => @my_js_tree_origen.right,
          :title => @my_js_tree_origen.title,
          :type => @my_js_tree_origen.type,
          :level => @my_js_tree_origen.level,
          :proceso_id => Proceso.last().id
      )

      @my_js_tree.save!

      @my_js_all_tress.push @my_js_tree
      @my_js_all_oldnew[@my_js_tree_origen.id] = MyJsTree.last().id

      @actividades = Actividad.find_all_by_plantilla_id(@id_plantilla)

      @actividades.each do |origen_act|

        @my_js_tree_origen = MyJsTree.find(origen_act.my_js_tree_id)
        @my_js_tree = MyJsTree.new(
            :parent_id => @my_js_tree_origen.parent_id,
            :position => @my_js_tree_origen.position,
            :left => @my_js_tree_origen.left,
            :right => @my_js_tree_origen.right,
            :title => @my_js_tree_origen.title,
            :type => @my_js_tree_origen.type,
            :level => @my_js_tree_origen.level,
            :proceso_id => Proceso.last().id
        )

        @my_js_tree.save!

        @my_js_all_tress.push @my_js_tree
        @my_js_all_oldnew[@my_js_tree_origen.id] = MyJsTree.last().id

        @actividad = Actividad.new(
          :nombre => origen_act.nombre,
          :descripcion => origen_act.descripcion,
          :modoejecucion => origen_act.modoejecucion,
          :duracion => origen_act.duracion,
          :horas_estimadas => 1,
          :num_instancias => 1,
          :tipocontrol => origen_act.tipocontrol,
          :proceso_id => Proceso.last().id,
          :my_js_tree_id => MyJsTree.last().id
        )

        if(@actividad.save!)

            @act_tipo_recursos = ActividadTiporecurso.find_all_by_actividad_id(origen_act.id)

            @act_tipo_recursos.each do |origen_acttiporec|
               @act_tipo_recurso = ActividadTiporecurso.new(
                  :actividad_id =>  Actividad.last().id,
                  :tipo_recurso_id => origen_acttiporec.tipo_recurso_id,
                  :cantidad => origen_acttiporec.cantidad
               )

               @act_tipo_recurso.save!

            end

            @act_tipo_artefactos = ActividadTipoartefacto.find_all_by_actividad_id(origen_act.id)

            @act_tipo_artefactos.each do |origen_acttipoart|
              @act_tipo_artefacto = ActividadTipoartefacto.new(
                :actividad_id =>  Actividad.last().id,
                :tipo_artefacto_id => origen_acttipoart.tipo_artefacto_id,
                :modo => origen_acttipoart.modo
              )

              @act_tipo_artefacto.save!

             end
        end

      end

      @compuertus = Compuertu.find_all_by_plantilla_id(@id_plantilla)

      @compuertus.each do |origen_com|

        @my_js_tree_origen = MyJsTree.find(origen_com.my_js_tree_id)
        @my_js_tree = MyJsTree.new(
            :parent_id => @my_js_tree_origen.parent_id,
            :position => @my_js_tree_origen.position,
            :left => @my_js_tree_origen.left,
            :right => @my_js_tree_origen.right,
            :title => @my_js_tree_origen.title,
            :type => @my_js_tree_origen.type,
            :level => @my_js_tree_origen.level,
            :proceso_id => Proceso.last().id
        )

        @my_js_tree.save!

        @my_js_all_tress.push @my_js_tree
        @my_js_all_oldnew[@my_js_tree_origen.id] = MyJsTree.last().id

        @compuertu = Compuertu.new(
            :nombre => origen_com.nombre,
            :descripcion => origen_com.descripcion,
            :tipo => origen_com.tipo,
            :desicion => origen_com.desicion,
            :proceso_id => Proceso.last().id ,
            :my_js_tree_id => MyJsTree.last().id
        )

      @compuertu.save!

      end

      @eventos = Evento.find_all_by_plantilla_id(@id_plantilla)

      @eventos.each do |origen_eve|

        @my_js_tree_origen = MyJsTree.find(origen_eve.my_js_tree_id)

        @my_js_tree = MyJsTree.new(
            :parent_id => @my_js_tree_origen.parent_id,
            :position => @my_js_tree_origen.position,
            :left => @my_js_tree_origen.left,
            :right => @my_js_tree_origen.right,
            :title => @my_js_tree_origen.title,
            :type => @my_js_tree_origen.type,
            :level => @my_js_tree_origen.level,
            :proceso_id => Proceso.last().id
        )

        @my_js_tree.save!

        @my_js_all_tress.push @my_js_tree
        @my_js_all_oldnew[@my_js_tree_origen.id] = MyJsTree.last().id

        @evento = Evento.new(
            :nombre => origen_eve.nombre,
            :tipo => origen_eve.tipo,
            :proceso_id => Proceso.last().id,
            :my_js_tree_id => MyJsTree.last().id
        )

      @evento.save!

      end

      @rutas = Rutum.find_all_by_plantilla_id(@id_plantilla)

      @rutas.each do |origen_rut|

        @my_js_tree_origen = MyJsTree.find(origen_rut.my_js_tree_id)

        @my_js_tree = MyJsTree.new(
            :parent_id => @my_js_tree_origen.parent_id,
            :position => @my_js_tree_origen.position,
            :left => @my_js_tree_origen.left,
            :right => @my_js_tree_origen.right,
            :title => @my_js_tree_origen.title,
            :type => @my_js_tree_origen.type,
            :level => @my_js_tree_origen.level,
            :proceso_id => Proceso.last().id
        )

        @my_js_tree.save!

        @my_js_all_tress.push @my_js_tree
        @my_js_all_oldnew[@my_js_tree_origen.id] = MyJsTree.last().id

        @ruta = Rutum.new(
            :nombre => origen_rut.nombre,
            :tipo => origen_rut.tipo,
            :proceso_id => Proceso.last().id,
            :my_js_tree_id => MyJsTree.last().id
        )

        @ruta.save!

      end


      @my_js_all_tress.each do |js_tree|
        js_tree.parent_id = @my_js_all_oldnew[js_tree.parent_id]
        js_tree.save!

      end
  end

  def aprobaciones
    @infotoshow = Array.new
    @proceso = Proceso.find(params[:id_proceso])
    @actividades = Actividad.where("proceso_id =" + @proceso.id.to_s + " AND modo_revision IS NOT NULL")

    @actividades.each do |unaactividad|
      @elemento = Hash.new
      @elemento["nombre"] = unaactividad.nombre
      @elemento["id"] = unaactividad.id
      @elemento["modo_revision"] = unaactividad.modo_revision
      @lastareas = Tarea.find_all_by_actividad_id(unaactividad.id)
      @subelemento = Array.new
      @lastareas.each do |unatarea|
        if !unatarea.es_aprobacion
          @subelementohash = Hash.new
          @subelementohash["tarea_nombre"] = unatarea.nombre
          @subelementohash["tarea_id"] = unatarea.id
          @subelementohash["revisiones"] = Array.new
          @subelementohash["aprobaciones"] = Array.new

          revisiones = TareaRevision.find_all_by_tarea_id(unatarea.id)
          revisiones.each do |unarevision|
            @revisionhash = Hash.new
            @revisionhash["usuario"] = Usuario.find(unarevision.usuario_id).nombre
            @revisionhash["aprobado"] = unarevision.aprobado.to_s
            @revisionhash["turno"] = unarevision.turno.to_s
            @subelementohash["revisiones"].push @revisionhash
          end

          aprobaciones = TareaAprobacion.find_all_by_tarea_id(unatarea.id, :order => "created_at ASC")
          aprobaciones.each do |unaaprobacion|
            @aprobacionhash = Hash.new
            @aprobacionhash["usuario"] = Usuario.find(unaaprobacion.usuario_id).nombre
            @aprobacionhash["aprobado"] = unaaprobacion.aprobado.to_s
            @aprobacionhash["fecha_aprobado"] = unaaprobacion.created_at
            @subelementohash["aprobaciones"].push @aprobacionhash
          end

          @subelemento.push @subelementohash
          @elemento["tareas"] = @subelemento
        end
      end

      @infotoshow.push @elemento

    end

    respond_to do |format|
      format.html { render layout: "actividads" }
      format.json { render json: @procesos }
    end
    #puts @infotoshow

  end

  def GenerateXPDL

    @proceso = Proceso.find(params[:id_proceso])

    _xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
    _xml += "<Package xmlns=\"http://www.wfmc.org/2004/XPDL2.0alpha\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"http://www.wfmc.org/2004/XPDL2.0alpha\">\n"
    _xml += " <WorkflowProcesses>\n"

    _xml += "   <WorkflowProcess Id=\"#{@proceso.id}\" Name=\"#{@proceso.nombre}\" AccessLevel=\"PUBLIC\">\n"

    _xml += "     <Participants>\n"

    _tipo_recursos =  TipoRecurso.all

    _tipo_recursos.each do |tipo_rec|
      _xml += "       <Participant id=\"#{tipo_rec.id}\">\n"
      _xml += "         <ParticipantType type=\"#{tipo_rec.nombre}\" />\n"
      _xml += "       </Participant>\n"
    end

    _xml += "     </Participants>\n"


    _xml += "     <Activities>\n"

    _eventos = Evento.find_all_by_proceso_id(@proceso.id)

    _eventos.each do  |evento|
       if(evento.tipo == 1) then
         _xml += "      <Activity Id=\"0\" Name=\"Start\">\n"
       else
         _xml += "      <Activity Id=\"-1\" Name=\"End\">\n"
       end

       _xml += "          <Event>\n"
       _xml += "          <IntermediateEvent Trigger=\"None\"/>\n"
       _xml += "          </Event>\n"
       _xml += "       </Activity>\n"

    end

    _activities = Actividad.find_all_by_proceso_id(@proceso.id)

    _activities.each do |_actividad|

      _xml += "       <Activity Id=\"#{_actividad.id}\" Name=\"#{_actividad.nombre}\">\n"

      _xml += "         <Implementation>\n"

      _tareas = Tarea.find_all_by_actividad_id(_actividad.id)

      _xml += "           <Task>\n"

       _tareas.each do |tarea|

         _xml += "            <TaskApplication id=\"#{tarea.nombre}\">\n"
         _xml += "            </TaskApplication>\n"

       end

      _xml += "           </Task>\n"

      _xml += "         </Implementation>\n"

      _xml += "         <TransitionRestrictions>\n"
      _xml += "           <TransitionRestriction>\n"
      _xml += "             <Split Type=\"XOR\">\n"
      _xml += "               <TransitionRefs>\n"
      _xml += "                 <TransitionRef Id=\"24\"/>\n"
      _xml += "                 <TransitionRef Id=\"28\"/>\n"
      _xml += "               </TransitionRefs>\n"
      _xml += "             </Split>\n"
      _xml += "           </TransitionRestriction>\n"
      _xml += "          </TransitionRestrictions>\n"

      _tipo_recursos = ActividadTiporecurso.find_all_by_actividad_id(_actividad.id)

      _tipo_recursos.each do |tipo_rec|

      _xml += "         <Performer>#{tipo_rec.tipo_recurso.id}</Performer>\n"

      end

      _xml += "       </Activity>\n"

    end

    _xml += "     </Activities>\n"

    _xml += "     <Transitions>\n"

    _precedencias = TareaPresedencium.find_all_by_proceso_id(@proceso.id)

    _precedencias.each do |precedencia|

      _xml += "       <Transition Id=\"#{precedencia.id}\" Name=\"\" From=\"#{precedencia.predecesora_id}\"  To=\"#{precedencia.sucesora_id}\" />\n"

    end

    _xml += "     </Transitions>\n"

    _xml += "   </WorkflowProcess>\n"
    _xml += " <WorkflowProcesses>\n"
    _xml += "</Package>"

    render text: _xml
  end

end
