class ProyectosController < ApplicationController

  before_filter :define_path
  before_filter :authenticate_user!

  @pag='Hola'

  def define_path
    @public_path = File.join(Rails.root.to_s, 'public')
    @uploads_url = '/uploads'
    @upload_path = File.join(@public_path, @uploads_url)
    @current_url = params[:dir] || @uploads_url
    @current_path = File.join(@public_path, @current_url)+ '/*'
  end
  

  def proy
    @organizacion=Organizacion.find_by_id(Usuario.find_by_id(current_user.id).organizacion_id)
    @proyectos = Proyecto.includes(:archivos).find_all_by_organizacion_id(@organizacion.id)
    @tipo_archivos = TipoArchivo.all.uniq

    @archivo = Archivo.new

      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @proyectos }
    end
  end
  # GET /proyectos
  # GET /proyectos.json
  def index
    @user1= current_user.id

    if (current_user.role? :nivel_1) || (current_user.role? :nivel_2)
      @organizacion=Organizacion.find_by_id(Usuario.find_by_id(current_user.id).organizacion_id)
      @empleados = Usuario.find_all_by_organizacion_id(@organizacion.id)

      #@proyectos = @organizacion.proyectos.sort_by(&:created_at).reverse
      @proyectos = Proyecto.all
      @proyecto = Proyecto.new

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @proyectos }
      end

    elsif current_user.role? :nivel_3
      redirect_to tarea_participantes_path
    elsif current_user.role? :nivel_0
      redirect_to plantillas_path
    else
      redirect_to request.protocol + request.host_with_port + "/users/sign_in"
    end
  end

  # GET /proyectos/1
  # GET /proyectos/1.json
  def show
   #
    @proyecto = Proyecto.find(params[:id])

    respond_to do |format|
     # if @pag='config'
        format.html { render :action => '_overview', :layout => 'proyectos1'}# show.html.erb
        format.json { render :layout => 'proyectos1'}#render json: @proyecto }
     # else
     #   format.html { render :action => 'overview', :layout => 'proyectos1'}# show.html.erb
     #   format.json { render :layout => 'proyectos1'}#render json: @proyecto }
     # end

    end
  end

  def configu
    #
    @tipo_plantillas=TipoPlantilla.all.uniq
    @proyecto = Proyecto.find(params[:id])
    @procesos= Proceso.find_all_by_proyecto_id(params[:id])
    @proyecto_organizacions =ProyectoOrganizacion.find_all_by_proyecto_id(params[:id])
    @proyecto_usuarios  =ProyectoUsuario.find_all_by_proyecto_id(params[:id])
    @proyecto_recursos  =ProyectoRecurso.find_all_by_proyecto_id(params[:id])
    @proyecto_artefactos  =ProyectoArtefacto.find_all_by_proyecto_id(params[:id])

    @proceso=Proceso.new
    @proyecto_organizacion = ProyectoOrganizacion.new

    respond_to do |format|
        format.html { render '_configuracion', :layout => 'proyectos1'}# show.html.erb
        format.json { render '_configuracion', :layout => 'proyectos1'}#render json: @proyecto }
    end
  end

  def configuempr
    #
    @tipo_plantillas=TipoPlantilla.all.uniq
    @proyecto = Proyecto.find(params[:id])
    @procesos= Proceso.find_all_by_proyecto_id(params[:id])
    @proyecto_organizacions =ProyectoOrganizacion.find_all_by_proyecto_id(params[:id])
    @proyecto_usuarios  =ProyectoUsuario.find_all_by_proyecto_id(params[:id])
    @proyecto_recursos  =ProyectoRecurso.find_all_by_proyecto_id(params[:id])
    @proyecto_artefactos  =ProyectoArtefacto.find_all_by_proyecto_id(params[:id])

    @proceso=Proceso.new
    @proyecto_organizacion = ProyectoOrganizacion.new

    respond_to do |format|
      format.html { render '_configuracionempr', :layout => 'proyectos1'}# show.html.erb
      format.json { render '_configuracionempr', :layout => 'proyectos1'}#render json: @proyecto }
    end
  end

  def configupart
    #
    @tipo_plantillas=TipoPlantilla.all.uniq
    @proyecto = Proyecto.find(params[:id])
    @procesos= Proceso.find_all_by_proyecto_id(params[:id])
    @proyecto_organizacions =ProyectoOrganizacion.find_all_by_proyecto_id(params[:id])
    @proyecto_usuarios  =ProyectoUsuario.find_all_by_proyecto_id(params[:id])
    @proyecto_recursos  =ProyectoRecurso.find_all_by_proyecto_id(params[:id])
    @proyecto_artefactos  =ProyectoArtefacto.find_all_by_proyecto_id(params[:id])

    @proceso=Proceso.new
    @proyecto_organizacion = ProyectoOrganizacion.new

    respond_to do |format|
      format.html { render '_configuracionpart', :layout => 'proyectos1'}# show.html.erb
      format.json { render '_configuracionpart', :layout => 'proyectos1'}#render json: @proyecto }
    end
  end

  def priorizar

    @proyecto = Proyecto.find(params[:id])
    @procesos=  Proyecto.find(params[:id]).procesos

    @data_for_select2 = Proyecto.find(params[:id]).usuarios

    @hash = Hash.new
    Proyecto.find(params[:id]).usuarios.each do |usuario|
      @hash[usuario.tipo_recurso_id] = Array.new
    end

    @hash.inject([]) { |result,h| result << h unless result.include?(h); result }
    @array = Array.new

    @hash.keys.each do |tipo_recurso_id|
      @tipoR=  TipoRecurso.find_by_id(tipo_recurso_id)
      @array.push( @tipoR)
    end

    @tipos=@array


    respond_to do |format|
      format.html { render '_priorizar', :layout => 'proyectos1'}# show.html.erb
      format.json { render '_priorizar', :layout => 'proyectos1'}#render json: @proyecto }
    end
  end
  @tareaSel=0

  def actualizarPriorizacion
    tareas = params[:tareas].split(':')

    prioridad = 0
    tareas.each do |tarea|

      prioridad = prioridad + 1
      @tareita= TareaParticipante.find_by_tarea_id_and_usuario_id(tarea,params[:usu])
      if(@tareita != nil)
        @tareita.prioridad=prioridad
        @tareita.save!
      end

    end

     render :text => "true"
  end

  def actualizarPrior
    @orden= params[:orden]


    $param=@orden.chomp.split(",")
    tam=$param.size
    prio=1;

    $param.each{ |a|
      a=a[11,a.bytesize]
      @tareita=TareaParticipante.find_by_usuario_id_and_tarea_id(params[:usu],a);
      @tareita.prioridad=prio;
      @tareita.save
      prio=prio+1;
    }



    render :text => "true"

  end


  def priorizarTareas

    @proyecto = Proyecto.find(params[:id])
    @usuario=Usuario.find(params[:idusuario])

    @tareaP = TareaParticipante.where(:usuario_id => @usuario.id).order("prioridad ASC").all
    @tareas = @usuario.tareas.order("tarea_id").all
    @tarea_revision = TareaRevision.new
    @tarea_artefacto = TareaArtefacto.new

    if(@tareaP.count > 0)
      @tarea_participante = @tareaP[0];
    else
      @tarea_participante = null;
    end

    @actividades = Array.new
    @tareaP.each do |tarea_participante|
      @actividades.push(tarea_participante.tarea.actividad)
    end

    #@hash = Hash.new
    #@tareaP.each do |tareaP|
    #   tarea=Tarea.find(tareaP.tarea_id)
    #   @hash[tarea.proceso_id] = Array.new
    # end

    # @hash.inject([]) { |result,h| result << h unless result.include?(h); result }
    # @array = Array.new

    # @hash.keys.each do |proceso_id|
    #  @proceso=  Proceso.find_by_id(proceso_id)
    #  if @proceso.proyecto_id=@proyecto.id
    #    @array.push( @proceso)
    #  end
    # end

    @procesos=@array

    respond_to do |format|
      format.html { render '_tareas', :layout => 'actividads'}# show.html.erb
      format.json { render '_tareas', :layout => 'actividads'}#render json: @proyecto }
    end
  end

  def arbol

    @proyecto = Proyecto.find(params[:id])
    @procesos=  Proyecto.find(params[:id]).procesos

    @data_for_select2 = Proyecto.find(params[:id]).usuarios

    @hash = Hash.new
    Proyecto.find(params[:id]).usuarios.each do |usuario|
      @hash[usuario.tipo_recurso_id] = Array.new
    end

    @hash.inject([]) { |result,h| result << h unless result.include?(h); result }
    @array = Array.new

    @hash.keys.each do |tipo_recurso_id|
      @tipoR=  TipoRecurso.find_by_id(tipo_recurso_id)
      @array.push( @tipoR)
    end

    @tipos=@array

    respond_to do |format|
      format.html { render '_arbol', :layout => 'reportes'}# show.html.erb
      format.json { render '_arbol', :layout => 'reportes'}#render json: @proyecto }
    end
  end


  def overview
    #
    @proyecto = Proyecto.find(params[:id])

    @procesos = Proceso.find_all_by_proyecto_id(@proyecto.id)
    @horasxproceso = Array.new
    @costoxproceso_estim = Array.new
    @costoxproceso_real = Array.new

    @nombres_estado = Array.new
    @cantidades_estado = Array.new
    @textos_estado = Array.new

    @cant_proceso_poriniciar_plan = Array.new
    @cant_proceso_enprogreso_plan = Array.new
    @cant_proceso_terminadas_plan = Array.new
    @cant_proceso_poriniciar_real = Array.new
    @cant_proceso_enprogreso_real = Array.new
    @cant_proceso_terminadas_real = Array.new

    # a continuacion llenar la info del grafico de piechart estados

    @estadoacts = EstadoActividad.find(:all)

    @estadoacts.each do |estadoact|
      @nombre_estado = estadoact.nombre

      @cant_tareas_estado = 0

      @texto_estado_proc = ""

      @procesos.each do |proceso|
        @tareas = proceso.tareas
        @tareas_del_proc = Tarea.find_all_by_proceso_id(proceso.id)

        @cant_tareas = 0

        @tareas_del_proc.each do |tareaproc|
          if tareaproc.estado == estadoact.id
            @cant_tareas = @cant_tareas + 1
          end
        end

        @cant_tareas_estado = @cant_tareas_estado + @cant_tareas
        @texto_estado_proc = @texto_estado_proc + "(proc_id " +  proceso.id.to_s + "): " + @cant_tareas.to_s +  " tareas. "


      end

      @nombres_estado.push @nombre_estado
      @cantidades_estado.push @cant_tareas_estado
      @textos_estado.push @texto_estado_proc
    end


    # a continuacion llenar la info del grafico de costo

    @procesos.each do |proceso|
      @horas_planeadas_en_proceso=0
      @costo_planeado = 0
      @costo_ejecutado = 0

      @costo=0
      @tareas = proceso.tareas

      @tareas.each do |tarea|
        @horas = tarea.horas_planeadas.to_i + @horas_planeadas_en_proceso

        @grupo_tareas = TareaParticipante.find_all_by_tarea_id(tarea.id)
        @grupo_tareas.each do |tareapart|
          @usuariotarea = Usuario.find_by_id(tareapart.usuario_id)
          @recursotarea = TipoRecurso.find_by_id(@usuariotarea.tipo_recurso_id)
          if(@recursotarea.cost != nil && tareapart.dedicacion != nil)
            @costo_planeado = @costo_planeado + (@recursotarea.cost * tareapart.dedicacion)
            @costo_ejecutado = @costo_ejecutado + (@recursotarea.cost * (tareapart.ejecutadas.nil? ? 0 : tareapart.ejecutadas))
          else
            @costo_planeado = @costo_planeado + 0
            @costo_ejecutado = @costo_ejecutado + 0
          end

        end

      end
      @horasxproceso.push @horas_planeadas_en_proceso
      @costoxproceso_estim.push @costo_planeado
      @costoxproceso_real.push @costo_ejecutado
    end

    # a continuacion llenar la info del grafico de estado tareas por proc
    # y fechas también

    @fecha_final_inicial = Date.today
    @fecha_final_de_todo = Date.new(1970)
    @una_fecha = DateTime.new
    #@costoxproceso_estim = Array.new
    @total_tareas = 0

    @procesos.each do |proceso|

      @col1_real = 0
      @col2_real = 0
      @col3_real = 0
      @col1_plan = 0
      @col2_plan = 0
      @col3_plan = 0

      @horas_planeadas_en_proceso=0
      @costo_planeado = 0
      @costo_ejecutado = 0

      @costo=0

      @tareas = proceso.tareas

      @tareas.each do |tarea|

      if tarea.fecha_inicio != nil
        if tarea.fecha_inicio > Date.today && tarea.fecha_fin < Date.today
            @col2_plan = @col2_plan + 1
        elsif Date.today > tarea.fecha_fin
            @col3_plan = @col3_plan + 1
        elsif Date.today < tarea.fecha_inicio
            @col1_plan = @col1_plan + 1
        end
      end

        if tarea.columna == 1
          @col1_real = @col1_real + 1
        elsif tarea.columna == 2
          @col2_real = @col2_real + 1
        elsif tarea.columna == 3
          @col3_real = @col3_real + 1
        end

        #info grafico fechas
      if tarea.fecha_inicio != nil
        if tarea.fecha_fin < @fecha_final_inicial
          @fecha_final_inicial = tarea.fecha_fin
          @una_fecha = tarea.updated_at
        end

        if tarea.fecha_fin > @fecha_final_de_todo
          @fecha_final_de_todo = tarea.fecha_fin
        end
      end

        @total_tareas = @total_tareas + 1

      end
      @cant_proceso_poriniciar_plan.push @col1_plan
      @cant_proceso_enprogreso_plan.push @col2_plan
      @cant_proceso_terminadas_plan.push @col3_plan
      @cant_proceso_poriniciar_real.push @col1_real
      @cant_proceso_enprogreso_real.push @col2_real
      @cant_proceso_terminadas_real.push @col3_real
    end

    @num_procesos=Proceso.find_all_by_proyecto_id(@proyecto.id).count
    @num_artefactos=ProyectoArtefacto.find_all_by_proyecto_id(@proyecto.id).count
    @num_organizaciones=ProyectoOrganizacion.find_all_by_proyecto_id(params[:id]).count
    @num_recursos=ProyectoRecurso.find_all_by_proyecto_id(params[:id]).count
    @num_usuarios=ProyectoUsuario.find_all_by_proyecto_id(params[:id]).count



    @fecha_final_inicials = @fecha_final_inicial.to_formatted_s(:short)
    @fecha_final_de_todos = @fecha_final_de_todo.to_formatted_s(:short)

    # más gráfico fechas

    date1 = Date.today
    date2 = Date.today
    business_days = 0
    date = date2
    while date > date1
      business_days = business_days + 1 unless date.saturday? or date.sunday?
      date = date - 1.day
    end


    respond_to do |format|
      format.html { render '_overview', :layout => 'proyectos1'}# show.html.erb
      format.json { render '_overview', :layout => 'proyectos1'}#render json: @proyecto }
    end
  end



  # GET /proyectos/new
  # GET /proyectos/new.json
  def new
    @proyecto = Proyecto.new
    @depositos = Deposito.all

       
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @proyecto }
    end
  end

  # GET /proyectos/1/edit
  def edit
    @proyecto = Proyecto.find(params[:id])
    @depositos = Deposito.all
  end

  # POST /proyectos
  # POST /proyectos.json
  def create
   # @depositos = Deposito.all
    @proyecto = Proyecto.new(params[:proyecto])
    @proyecto.fcreado=Time.now
    @proyecto.organizacion_id=Usuario.find_by_id(current_user.id).organizacion_id
    @empleados = Usuario.find_all_by_organizacion_id(@proyecto.organizacion_id)
    @razuna_folder = @proyecto.nombre

    respond_to do |format|
      if @proyecto.save
        @proyeOrg=ProyectoOrganizacion.new
        @proyeOrg.proyecto_id=@proyecto.id
        @proyeOrg.organizacion_id=@proyecto.organizacion_id
        @proyeOrg.save

        begin
          @wddx = WDDX.load(open(ENV['root_razuna_api'] + "global/api2/folder.cfc?method=setfolder&api_key=" + ENV['admindavid_razuna_key'] + "&folder_name=" +  CGI::escape(@proyecto.nombre) + "&__BDRETURNFORMAT=wddx"))
        rescue
        end

        @proyecto = Proyecto.new
        @proyectos = Proyecto.all

        @message = t('datos_guardados')

        format.html { render action: "index" }
        format.json { render json: @proyectos }
      else
        format.html { render action: "new" }
        format.json { render json: @proyecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /proyectos/1
  # PUT /proyectos/1.json
  def update
    @proyecto = Proyecto.find(params[:id])
    
    respond_to do |format|
      if @proyecto.update_attributes(params[:proyecto])
        format.html { redirect_to @proyecto, notice: 'El proyecto fue editado satisfactoriamente.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @proyecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proyectos/1
  # DELETE /proyectos/1.json
  def destroy
    @proyecto = Proyecto.find(params[:id])
    @proyecto.destroy

    respond_to do |format|
      format.html { redirect_to proyectos_url }
      format.json { head :no_content }
    end
  end

  # ===  Accion existe
  # Determina si existe un proyecto de acuerdo a un nombre
  def existe
    @proyecto = Proyecto.find_by_nombre(params[:nombre])
    if(@proyecto)
      render :text => "true"
    else
      render :text => "false"
    end
  end

  def get_organizaciones
    @data_for_select2 = Organizacion.all

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

    render :text => @data
  end

  def get_usuarios_org
    @comilla='"';
    @data_for_select1 = params[:organizacion_id]

    @data_for_select2 = Usuario.find_all_by_organizacion_id(@data_for_select1)
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




  def getTipoRecurso

    @data_for_select2 = Proyecto.find(params[:id]).usuarios

    @hash = Hash.new
    Proyecto.find(params[:id]).usuarios.each do |usuario|
      @hash[usuario.tipo_recurso_id] = Array.new
    end

    @hash.inject([]) { |result,h| result << h unless result.include?(h); result }
    @array = Array.new

      @hash.keys.each do |tipo_recurso_id|
      @tipoR=  TipoRecurso.find_by_id(tipo_recurso_id)
      @array.push( @tipoR)
    end


    @data_for_select2=  @array

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
    @data_for_select1 = params[:tipo_recurso]

    @data_for_select2 =  Proyecto.find(params[:id]).usuarios.where(:tipo_recurso_id => @data_for_select1).all
    @procesos=  Proyecto.find(params[:id]).procesos

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

  def listar_procesos
    @usuario=Usuario.find_by_id(params[:id])
    @tareas=@usuario.tareas
    render :text => true
  end

  protected

  def secured_path?(file_path)
    return File.exist?(file_path) && ! File.dirname(file_path).index(@public_path).nil?
  end



  def slugify(value)
    return value.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n, '').to_s\
          .downcase\
          .gsub(/[']+/, '')\
          .gsub(/\W+/, ' ')\
          .strip\
          .gsub(' ', '-')
  end

end


