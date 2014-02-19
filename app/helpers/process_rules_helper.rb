module ProcessRulesHelper
  #METODOS GLOBALES
  def eventos_proceso proceso

    if(proceso.estado == "publicado")
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

          rule 'IsDesicionTask' do
            parameter Integer
            condition   { tarea.es_desicion }
            consequence { evento_desicion(tarea) }
          end

          if(!tarea.es_aprobacion)
            rule 'IsRevisionToBegin' do
              parameter Integer
              condition   { revision_start(tarea) }
              consequence { iniciar_flujo_revision(tarea) }
            end
          end

          if(tarea.es_aprobacion)
            rule 'IsRevisionEvent' do
              parameter Integer
              condition   { revision_event(tarea) }
              consequence { evento_flujo_revision(tarea) }
            end
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

  def revision_start tarea
    return (tarea.columna == 3 && tarea.actividad.modo_revision != nil && tarea.actividad.modo_revision != "auto")
  end

  def revision_event tarea
    return (tarea.columna == 3 && tarea.actividad.modo_revision != nil && tarea.actividad.modo_revision != "auto")
  end

  def iniciar_flujo_revision tarea
    _flujo_iniciado = false
    Tarea.find_all_by_tarea_revisar_id(tarea.id).each do |tarea_revision|
      if(tarea_revision.activada)
        _flujo_iniciado = true
      end
    end

    if(!_flujo_iniciado)
      Tarea.find_all_by_tarea_revisar_id(tarea.id).each do |tarea_revision|
        tarea_revision.activada = 1
        tarea_revision.save!
      end

      TareaRevision.find_all_by_tarea_id(tarea.id).each do |revision|
        revision.aprobado = nil
        revision.save!
      end
    end
  end

  def evento_flujo_revision tarea

    #TareaPresedencium.find_all_by_predecesora_id_and_tipo_relacion(tarea.id,"revision").each do |presedencia|

    #tarea_revision = Tarea.find(presedencia.sucesora_id)
    #if(tarea_revision != nil) then
    #tarea_revision.activado = true
    #tarea_revision.save!
    #end
    #end
    #end
    tarea_revisar = Tarea.find(tarea.tarea_revisar_id)

    rechazada = (TareaRevision.find_all_by_tarea_id_and_aprobado(tarea_revisar.id, 0).count > 0)

    if(rechazada)

      TareaRevision.find_all_by_tarea_id(tarea_revisar.id).each do |revision|
        revision.aprobado = 0
        revision.save!
      end

      Tarea.find_all_by_tarea_revisar_id(tarea_revisar.id).each do |tarea_revision|
        tarea_revision.estado = 8
        tarea_revision.columna = 4
        tarea_revision.activada = 1
        tarea_revision.save!
      end

      tarea_revisar.estado = 1
      tarea_revisar.columna = 1
      tarea_revisar.save!

    else

      num_revisiones = TareaRevision.find_all_by_tarea_id(tarea_revisar.id).count
      num_aceptados = TareaRevision.find_all_by_tarea_id_and_aprobado(tarea_revisar.id, true).count

      if num_revisiones == num_aceptados then

        Tarea.find_all_by_tarea_revisar_id(tarea_revisar.id).each do |tarea_revision|
          tarea_revision.estado = 8
          tarea_revision.columna = 4
          tarea_revision.activada = 1
          tarea_revision.save!
        end

        tarea_revisar.estado = 8
        tarea_revisar.columna = 4
        tarea_revisar.save!

      end
    end
  end

  def evento_desicion tarea
    _desisiones = CompuertaDesicion.find_all_by_tarea_desicion_id(tarea.id)

    _desisiones.each do |_desicion|

      _ruta = Rutum.find(_desicion.ruta_id)
      _nodes = MyJsTree.find_all_by_parent_id(_ruta.my_js_tree_id)

      _nodes.each do |node|

        _actividad = Actividad.find_by_my_js_tree_id(node.id)
        if(_actividad != nil)
          _tarea = Tarea.find_by_actividad_id(_actividad.id)
          _tarea.activada = _desicion.elegida
          _tarea.save!
        end
      end
    end
  end
end
