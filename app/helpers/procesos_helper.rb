module ProcesosHelper

  def generar_reporte(proceso_id)

      @proceso = Proceso.find(proceso_id)
      @duracion=(@proceso.proyecto.fecha_fin-@proceso.proyecto.fecha_inicio).to_i
      #@duracion=(@duracion/30).to_i

      @tipo_recursos=TipoRecurso.all

      if(!@proceso.proyecto.presupuesto)
        @proceso.proyecto.presupuesto = 0
      end

      File.open('app/views/procesos/template.tjp', 'w') do |f2|

        datos_proceso(f2)

        datos_reportes(f2)

        datos_burdown()
      end

      if RUBY_PLATFORM =~ /linux/ then
        system("export LC_CTYPE=en_US.UTF-8")
        #system("export LC_CTYPE=en_US.ISO8859-1")

        system("rm app/views/procesos/*html")

        system("tj3 app/views/procesos/template.tjp")
        puts Dir.pwd
        @dir=Dir.pwd.to_s

        system("ls -lt ./*html")
        system("mv ./Overview.html app/views/procesos/Overview.html")
        system("mv ./ContactList.html app/views/procesos/ContactList.html")
        system("mv ./Deliveries.html app/views/procesos/Deliveries.html")
        system("mv ./Development.html app/views/procesos/Development.html")
        system("mv ./ResourceGraph.html app/views/procesos/ResourceGraph.html")
        system("mv ./resourcesM.html app/views/procesos/resourcesM.html")
        system("mv ./BurndownChart.html app/views/procesos/BurndownChart.html")
        # system("mv ./BurndownChart.csv app/views/procesos/BurndownChart.csv")

        system("ls -lt app/views/procesos/*html")
      else

        system("tj3 app/views/procesos/template.tjp")

        puts Dir.pwd
        @dir=Dir.pwd.to_s

        FileUtils.move 'Overview.html', @dir+'\\app\\views\\procesos\\Overview.html'
        FileUtils.move 'ContactList.html', @dir+'\\app\\views\\procesos\\ContactList.html'
        FileUtils.move 'Deliveries.html', @dir+'\\app\\views\\procesos\\Deliveries.html'
        FileUtils.move 'Development.html', @dir+'\\app\\views\\procesos\\Development.html'
        FileUtils.move 'ResourceGraph.html', @dir+'\\app\\views\\procesos\\ResourceGraph.html'
        FileUtils.move 'resourcesM.html', @dir+'\\app\\views\\procesos\\resourcesM.html'
        FileUtils.move 'BurndownChart.html', @dir+'\\app\\views\\procesos\\BurndownChart.html'
        # FileUtils.move 'BurndownChart.csv', @dir+'\\app\\views\\procesos\\BurndownChart.csv'
      end

  end

  def datos_proceso(f2)

    f2.puts "
        project acso \"#{@proceso.proyecto.nombre}\" #{@proceso.proyecto.fecha_inicio.to_s} - #{@proceso.proyecto.fecha_fin.to_s} {
          timezone \"America/Bogota\"
          timeformat \"%Y-%m-%d %H:%M:%S %z\"
          numberformat \"-\" \"\" \",\" \".\" 1
          currencyformat \"(\"  \")\" \",\" \".\" 0
          now #{Time.now.strftime("%Y-%m-%d-%H:00")}
          currency \"COP\"

          alertlevels green \"Correcto\" \"#2AA46C\",
          blue \"Advertencia\" \"#457CC4\",
          yellow \"Medio\" \"#F1D821\",
          orange \"Alto\" \"#F99836\",
          red \"Severo\" \"#E43745\"

          scenario plan \"Plan\" {
              scenario delayed \"Delayed\"
              projection
            }
            extend resource {
              text Phone \"Phone\"
            }
          }

          rate #{@proceso.proyecto.presupuesto.to_s}
          flags equipo
          flags persona
          flags material
          flags cosas

        account cost \"Project Cost\" { "

    @tipo_recursos.each do |tipo_recurso|
      if tipo_recurso.unit==1
        f2.puts "       account tipo_recH#{tipo_recurso.id.to_s} \"#{tipo_recurso.nombre.to_s}\""
      else
        f2.puts "       account tipo_recM#{tipo_recurso.id.to_s} \"#{tipo_recurso.nombre.to_s}\""
      end
    end
    f2.puts " }

        account rev \"Payments\"
        balance cost rev

        resource boss \"#{Usuario.find_by_id(@proceso.proyecto.director).nombre}\" {
          email \"#{@proceso.proyecto.director.to_s}\"
          Phone \"#{@proceso.proyecto.director.to_s}\"
          rate #{@proceso.proyecto.presupuesto.to_s}
        }

        resource undefined \"No Definido\" {
          email \"No Definido\"
          Phone \"No Definido\"
          rate 0
        }"

    #RECURSOS
    @tipo_recursos.each do |tipo_recurso|
      if tipo_recurso.unit==1
        f2.puts "resource tipo_recH#{tipo_recurso.id.to_s} \"#{tipo_recurso.nombre.to_s}\" {"
        @proceso.proyecto.usuarios.each do |usuario|
          if usuario.tipo_recurso_id==tipo_recurso.id
            f2.puts "resource recH#{usuario.id.to_s} \"#{usuario.nombre.to_s}\" {
                   email \"#{usuario.email.to_s}\"
                   Phone \"#{usuario.nombre.to_s}\"
                   rate #{ usuario.tipo_recurso.cost != nil ? usuario.tipo_recurso.cost.to_s : "0" }
                   flags persona }"
          end

        end
        f2.puts " flags equipo }"
      end
    end

    @tipo_recursos.each do |tipo_recurso|
      if tipo_recurso.unit==2
        f2.puts "resource tipo_recM#{tipo_recurso.id.to_s} \"#{tipo_recurso.nombre.to_s}\" {"
        @proceso.proyecto.recursos.each do |recurso|
          if recurso.tipo_recurso_id==tipo_recurso.id
            f2.puts "resource recM#{recurso.id.to_s} \"#{recurso.nombre.to_s}\" {
               #unidades \"#{recurso.unidades.to_s}\"
               rate #{recurso.costo.to_s}
               flags cosas }"
          end
        end
        f2.puts " flags material }"
      end
    end

    #TAREAS

    f2.puts "task AcSo \"#{@proceso.nombre} \" {
                    responsible boss
                    "

    @proceso.tareas.each do |tarea|
      f2.puts "   task tarea"+tarea.id.to_s+" "+ "\""+tarea.nombre.to_s+ "\""+" {
                      priority #{tarea.prioridad != nil ? tarea.prioridad.to_s : "1"}
                      effort #{tarea.horas_planeadas != nil ? tarea.horas_planeadas.to_s : "1"}h
                      complete #{tarea.estado == 8 ? "100" : tarea.avance != nil ? tarea.avance.to_s : "0" }"

      if(tarea.horas_planeadas != nil && tarea.horas_ejecutadas != nil && tarea.horas_planeadas < tarea.horas_ejecutadas)
      f2.puts "       journalentry  #{Time.now.strftime("%Y-%m-%d-%H:00")} \"Tarea excedio tiempo planeado \" {
              alert yellow }"
      end

      if(tarea.fecha_fin != nil && tarea.fecha_fin < Date.today && tarea.avance == nil)
        f2.puts "       journalentry  #{Time.now.strftime("%Y-%m-%d-%H:00")} \"Tarea esta atrazada\" {
              alert red }"
      end

      if tarea.usuarios.count == 0
        f2.puts "   allocate undefined"
      else
        _recursos = ""
        tarea.usuarios.each do |recurso|
          _recursos = _recursos + "recH#{recurso.id.to_s},"
        end

        tarea.recursos.each do |recurso|
          _recursos = _recursos + "recM#{recurso.id.to_s},"
        end

        _recursos =  _recursos[0.._recursos.length-2]
        f2.puts "allocate " + _recursos
      end


      _precedencias = ""
      _isfound = false
      TareaPresedencium.find_all_by_sucesora_id(tarea.id).each do |presedencia|
        if  presedencia.predecesora_id != nil
          _precedencias = _precedencias + "!tarea#{presedencia.predecesora_id.to_s},"
          _isfound = true
        end
      end

      if(_isfound)
        _precedencias = _precedencias[0.._precedencias.length-2]
        f2.puts "depends " + _precedencias
      else
        f2.puts "depends !deliveries.start"
      end
      f2.puts "}"
    end

    #MILESTONES
    f2.puts "task deliveries \"Milestones\" {

          purge chargeset
          chargeset rev

          task start \"#{t('.inicio')}\" {
            start ${projectstart}
            charge 0.0 onstart
          }
        }
     }"
  end

  def datos_reportes(f2)
    f2.puts "
      navigator navbar {
        hidereport @none
      }

      macro TaskTip [
        tooltip istask() -8<-
        '''Start: ''' <-query attribute='start'->
        '''End: ''' <-query attribute='end'->
        ----
        '''Resources:'''
        <-query attribute='resources'->
        ----
        '''Precursors: '''
        <-query attribute='precursors'->
        ----
        '''Followers: '''
        <-query attribute='followers'->
        ->8-
      ]

      textreport frame \"\" {
        header -8<-
        <[navigator id=\"navbar\"]>
        ->8-
        footer \"----\"
        textreport index \"Overview\" {
        formats html
        title \"#{t('.principal')}\"
        center '<[report id=\"overview\"]>'
        }

        textreport development \"Development\" {
          formats html
          title \"#{t('.desarrollo')}\"
          center '<[report id="+ "\""+"development"+ "\""+"]>'
          }

        textreport \"Deliveries\" {
          formats html
          title \"#{t('.status')}\"
          center -8<-
          <[report id=\"status.completed\"]>
          ----
          <[report id=\"status.ongoing\"]>
          ----
          <[report id=\"status.future\"]>
          ->8-
        }

        textreport  \"Burndown\" {
          formats html
          title \"#{t('.burndown')}\"
          width 800
          sorttasks id.up
          tracereport \"BurndownChart\" {
          columns
            effort { title 'Planeado' },
            effort { title 'Ejecutado' }
            hidetask plan.id != \"AcSo\"
          }
          purge formats
        }


        textreport \"ResourceGraph\" {
          formats html
          title \"#{t('.recursosM')}\"
          center '<[report id=\"resourceGraph\"]>'
        }

        textreport \"ContactList\" {
          formats html
          title \"#{t('.recursoHumano')}\"
          center '<[report id=\"contactList\"]>'
        }

        textreport \"resourcesM\" {
          formats html
          title \"#{t('.recursoMaterial')}\"
          center '<[report id=\"resourcesM\"]>'
        }
      }

      # A traditional Gantt chart with a project overview.
      taskreport overview \"\" {
        header -8<-
        === "+t('.titulo')+" ===
        ->8-
        columns bsi { title 'WBS'  },
        name { title 'Nombre' },
        start { title 'Fecha inicio' },
        end { title 'Fecha fin' },
        effort { title 'Esfuerzo' },
        chart { ${TaskTip}  scale day width 500 }
        timeformat '%d %Y-%m-%d'
        loadunit days
        hideresource @all
        balance cost rev
        caption '"+t('.comentario')+"'

        }

        # Macro to set the background color of a cell according to the alert
        # level of the task.
        macro AlertColor [
          cellcolor plan.alert = 0 '#00D000' # green
          cellcolor plan.alert = 1 '#D0D000' # yellow
          cellcolor plan.alert = 2 '#D00000' # red
        ]

        taskreport status \"\" {
          columns bsi { width 50 title 'WBS' },
          name { width 150 title 'Nombre' },
          start { width 100 title 'Fecha Inicio' },
          end { width 100 title 'Fecha Fin' },
          effort { width 100 title 'Esfuerzo' },
          alert { title '' tooltip plan.journal != '' \"<-query attribute='journal'->\" width 15 },
          status { title 'Estado' width 150 }
          timeformat \""+"%d %Y-%m-%d\"
          scenarios delayed
          taskreport completed \"\" {
          headline \"Tareas completadas\"
          hidetask ~(delayed.end <= ${now})
          }

          taskreport ongoing \"\" {
            headline \"Tareas en curso\"
            hidetask ~((delayed.start <= ${now}) & (delayed.end > ${now}))
          }

          taskreport future \"\" {
            headline \"Tareas por realizar\"
            hidetask ~(delayed.start > ${now})
          }
        }

        # A list of tasks showing the resources assigned to each task.
        taskreport development \"\" {
          scenarios delayed
          headline \"#{t('.tituloG')}\"
          columns
          bsi { title 'WBS' },
          name { title \"#{t('.nombre')}\" },
          start { title \"Fecha inicio\" },
          end { title \"Fecha fin\" },
          effort { title \"Trabajo\" },
          duration { title \"Duracion\" },
          chart { ${TaskTip} scale day width 500 }
          timeformat \"%Y-%m-%d\"
          hideresource ~(isleaf() & isleaf_())
          sortresources name.up
        }

        # A list of all tasks with the percentage completed for each task
        taskreport deliveries \"\" {
          headline \"Entregables del proceso\"
          columns bsi { title \"WBS\" },
          name { title \"Nombre\" },
          start { title \"Fecha inicio\" },
          end { title \"Fecha fin\" },
          note { title \"Nota\" width 150 },
          complete { title \"Avance\" },
          chart { ${TaskTip} }
          taskroot AcSo.deliveries
          hideresource @all
          scenarios plan, delayed
        }

        # A list of all employees with their contact details.
        resourcereport contactList \"\" {
          scenarios delayed
          headline \"Lista de contactos\"
          columns name { title \"Nombre\" },
          email { celltext 1 \"[mailto:<-email-> <-email->]\" },
          Phone { title \"Telefono\" },
          managers { title \"Jefe\" },
          chart { scale day }
          hideresource  ~persona
          sortresources name.up
          hidetask @all
        }

        # A list of all employees with their contact details.
        resourcereport resourcesM \"\" {
          scenarios delayed
          headline \"Utilizacion de recursos\"
          columns name { title \"Nombre\" },
          chart { scale day }
          hideresource  ~cosas
          sortresources name.up
          hidetask @all
        }

        # A graph showing resource allocation. It identifies whether each
        # resource is under- or over-allocated for.
        resourcereport resourceGraph \"\" {
          scenarios delayed
          headline \"Asignacion de recursos\"
          columns no,
          name { title \"Nombre\" },
          effort { title \"Duracion\" },
          rate { title \"Costo/dia\" },
          weekly { ${TaskTip} }
          loadunit shortauto
          # We only like to show leaf tasks for leaf resources.
          hidetask ~(isleaf() & isleaf_())
          sorttasks plan.start.up
        }

    export \"MS-Project\" {
      formats mspxml
      loadunit quarters
    }"

  end

  def datos_burdown()
    File.open('BurndownChart.csv', 'w') do |f1|
      f1.puts "Date;Planeado;Ejecutado"
      _totalplaneadas = 0
      _totalejecutadas = 0
      @proceso.tareas(:fecha_inicio).each do |tarea|
        _totalplaneadas += tarea.horas_planeadas != nil ? tarea.horas_planeadas : 0;
      end

      _totalejecutadas = _totalplaneadas

      _fechas = Array.new

      @proceso.tareas.order(:fecha_inicio).each do |tarea|

        _totalplaneadas -= tarea.horas_planeadas != nil ? tarea.horas_planeadas : 0
        _totalejecutadas -= tarea.horas_ejecutadas != nil ? tarea.horas_ejecutadas : 0

        if(tarea.fecha_inicio != nil && tarea.horas_planeadas != nil && _fechas.include?(tarea.fecha_inicio) == false)
          _fechas.push(tarea.fecha_inicio)
          f1.puts "#{tarea.fecha_inicio.to_s};#{_totalplaneadas.to_s};#{_totalejecutadas.to_s}"
        end

      end

    end
  end
end