class ProcessRulesController < ApplicationController

  def validate_process
    rules = nil
    @errors = Array.new

      proceso = Proceso.find(params[:proceso_id])

      ProcesoValidacion.find_all_by_proceso_id(proceso.id).each do |validacion|
        validacion.destroy
      end

      #process_rules

      process_rules = Rools::RuleSet.new do
        rule 'ProcessHasStartEvent' do
          parameter Integer
          condition { Evento.find_all_by_proceso_id_and_tipo( proceso.id, 1 ).count == 0 }
          consequence { ProcesoValidacion.new(:proceso_id => proceso.id, :error_message => "<span>proceso " + proceso.nombre.upcase + "</span> no tiene evento de inicio", :tipo => "error").save! }
        end

        rule 'ProcessHasEndEvent' do
          parameter Integer
          condition { Evento.find_all_by_proceso_id_and_tipo( proceso.id, 2 ).count == 0 }
          consequence { ProcesoValidacion.new(:proceso_id => proceso.id, :error_message => "<span>proceso " + proceso.nombre.upcase + "</span> no tiene evento de fin", :tipo => "error").save! }
        end

      end

      process_rules.assert proceso.id

      Tarea.find_all_by_proceso_id(proceso.id).each do |tarea|

        task_rules = Rools::RuleSet.new do

          rule 'TaskHasResponsable' do
            parameter Integer
            condition { tarea.tarea_participantes.count == 0 && !tarea.es_aprobacion }
            consequence { ProcesoValidacion.new(:proceso_id => proceso.id, :error_message => "<span>tarea " + tarea.nombre.upcase + "</span> no tiene responsable", :tipo => "error").save! }
          end

          rule 'TaskHasRevision' do
            parameter Integer
            condition { tarea.actividad.modo_revision != nil &&
                tarea.actividad.modo_revision != 'auto' &&
                tarea.tarea_revisions.count == 0 &&
                !tarea.es_aprobacion }
            consequence { ProcesoValidacion.new(:proceso_id => proceso.id, :error_message => "<span>tarea " + tarea.nombre.upcase + "</span> requiere aprobacion pero no tiene revisiones creadas", :tipo => "warning").save! }
          end

          rule 'TaskHasPlanedHours' do
            parameter Integer
            condition { tarea.actividad.tipocontrol == 'horas' &&
                tarea.horas_planeadas == nil }
            consequence { ProcesoValidacion.new(:proceso_id => proceso.id, :error_message => "<span>tarea " + tarea.nombre.upcase + "</span> se controla por horas pero no tiene definidas horas planeadas", :tipo => "warning").save! }
          end

       #   rule 'TaskHasStartDate' do
       #     parameter Integer
       #     condition { tarea.actividad.tipocontrol == 'fechas' &&
       #         tarea.fecha_inicio == nil  }
       #     consequence { ProcesoValidacion.new(:proceso_id => proceso.id, :error_message => "<span>tarea " + tarea.nombre.upcase + "</span> se controla por fechas pero no tiene definida fecha de inicio", :tipo => "warning").save! }
       #   end

        #  rule 'TaskHasEndDate' do
        #    parameter Integer
        #    condition { tarea.actividad.tipocontrol == 'fechas' &&
        #        tarea.fecha_fin == nil  }
        #    consequence {ProcesoValidacion.new(:proceso_id => proceso.id, :error_message => "<span>tarea " + tarea.nombre.upcase + "</span> se controla por fechas pero no tiene definida fecha de fin", :tipo => "warning").save! }
        #  end

        end

        task_rules.assert tarea.id

      end

      Compuertu.find_all_by_proceso_id(proceso.id).each do |compuerta|

        gateway_rules = Rools::RuleSet.new do
          rule 'GatewayHasRoutes' do
            parameter Integer
            condition { MyJsTree.find_all_by_parent_id(compuerta.my_js_tree_id).count == 0 }
            consequence { ProcesoValidacion.new(:proceso_id => proceso.id, :error_message => "<span>compuerta " + compuerta.nombre.upcase + "</span> no tiene rutas validas", :tipo => "error").save! }
          end
        end

        gateway_rules.assert compuerta.id

      end

    Rutum.find_all_by_proceso_id(proceso.id).each do |ruta|

      route_rules = Rools::RuleSet.new do
        rule 'RouteHasTask' do
          parameter Integer
          condition { MyJsTree.find_all_by_parent_id(ruta.my_js_tree_id).count == 0 }
          consequence { ProcesoValidacion.new(:proceso_id => proceso.id, :error_message => "<span>ruta " + ruta.nombre.upcase + "</span> no tiene tareas validas", :tipo => "error").save! }
        end
      end

      route_rules.assert ruta.id

    end

    if(params[:publicar] == "false")

      respond_to do |format|
        format.html { render action: "validate_process", :layout => "actividads" }
        format.json { head :no_content }
      end

    end

  end

  def publicar_proceso

    validate_process

    proceso = Proceso.find(params[:proceso_id])

    if(params[:publicar] == "true")

      error_list = ProcesoValidacion.find_all_by_proceso_id(proceso.id)

      if(error_list.length > 0)

        respond_to do |format|
          format.html { render action: "validate_process", :layout => "actividads" }
          format.json { head :no_content }
        end

      else

        iniciar_proceso

        respond_to do |format|
          format.html { render action: "publicar_proceso", :layout => "actividads" }
          format.json { head :no_content }
        end

        proceso.estado = "publicado"
        proceso.save!

      end


    end
  end

  def iniciar_proceso

    proceso = Proceso.find(params[:proceso_id])

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
