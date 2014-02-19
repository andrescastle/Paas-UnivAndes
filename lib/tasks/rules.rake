namespace :rules do
  desc "TODO"
  task :test => :environment do

    puts "Ejecutando reglas..."

    sleep(1)

    rules = nil

    Proceso.all.each do |proceso|
      puts " Proceso:" + proceso.nombre
      sleep(1)
      puts "  Validando integridad del proceso"
      sleep(1)

      #process_rules

      process_rules = Rools::RuleSet.new do

        rule 'ProcessHasStartEvent' do
          parameter Integer
          condition { Evento.find_all_by_proceso_id_and_tipo( proceso.id, 1 ).count == 0 }
          consequence { puts "   proceso '" + proceso.nombre + "' no tiene evento de inicio" }
        end

        rule 'ProcessHasEndEvent' do
          parameter Integer
          condition { Evento.find_all_by_proceso_id_and_tipo( proceso.id, 2 ).count == 0 }
          consequence { puts "   proceso '" + proceso.nombre + " no tiene evento de fin" }
        end

      end

      process_rules.assert proceso.id

      Tarea.find_all_by_proceso_id(proceso.id).each do |tarea|

        task_rules = Rools::RuleSet.new do

          rule 'TaskHasResponsable' do
            parameter Integer
            condition { tarea.tarea_participantes.count == 0 }
            consequence { puts "   tarea '" + tarea.nombre + "' no tiene responsable" }
          end

          rule 'TaskHasRevision' do
            parameter Integer
            condition { tarea.actividad.modo_revision != nil &&
                        tarea.actividad.modo_revision != 'auto' &&
                        tarea.tarea_revisions.count == 0 }
            consequence { puts "   tarea '" + tarea.nombre + "' requiere aprobacion pero no tiene revisiones creadas" }
          end

          rule 'TaskHasPlanedHours' do
            parameter Integer
            condition { tarea.actividad.tipocontrol == 'horas' &&
                        tarea.horas_planeadas == nil }
            consequence { puts "   tarea '" + tarea.nombre + "' se controla por horas pero no tiene definidas horas planeadas" }
          end

          rule 'TaskHasStartDate' do
            parameter Integer
            condition { tarea.actividad.tipocontrol == 'fechas' &&
                        tarea.fecha_inicio == nil  }
            consequence { puts "   tarea '" + tarea.nombre + "' se controla por fechas pero no tiene definida fecha de inicio" }
          end

          rule 'TaskHasEndDate' do
            parameter Integer
            condition { tarea.actividad.tipocontrol == 'fechas' &&
                        tarea.fecha_fin == nil  }
            consequence { puts "   tarea '" + tarea.nombre + "' se controla por fechas pero no tiene definida fecha de fin" }
          end

        end

        task_rules.assert tarea.id

      end
    end
  end

  task :run => :environment do
    Proceso.all.each do |proceso|

      puts " Proceso:" + proceso.nombre
      sleep(1)
      puts "  Ejecutando el proceso"
      sleep(1)

      Tarea.find_all_by_proceso_id(proceso.id).each do |tarea|

        task_rules = Rools::RuleSet.new do

          rule 'IsFirstTask' do
            parameter Integer
            condition   { is_first_task(tarea) }
            consequence { tarea.update_attribute(:activada, 1) }
          end

          rule 'PredecessorsIsAprobed' do
            parameter Integer
            condition   { predecesoras_aprobadas(tarea) }
            consequence { tarea.update_attribute(:activada, 1) }
          end

        end

        task_rules.assert tarea.id

      end
    end
  end

  def predecesoras_aprobadas tarea
    aprobadas = true
    TareaPresedencium.find_all_by_sucesora_id(tarea.id).each do |presedencia|

      tarea = Tarea.find(presedencia.predecesora_id)
      if(tarea != nil && tarea.columna != 4) then
        aprobadas = false
      end
    end

    return aprobadas
  end

  def is_first_task tarea
    return (TareaPresedencium.find_all_by_sucesora_id_and_predecesora_id(tarea.id, nil).count > 0)
  end

end