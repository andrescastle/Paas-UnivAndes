class Tarea < ActiveRecord::Base
  belongs_to :actividad, :foreign_key => 'actividad_id'
  belongs_to :compuertu, :foreign_key => 'compuerta_id'
  belongs_to :usuario, :foreign_key => 'responsable_id'
  belongs_to :proceso, :foreign_key => 'proceso_id'

  attr_accessible :actividad_id,
                  :avance,
                  :comentarios,
                  :descripcion,
                  :duracion,
                  :estado,
                  :fecha_fin,
                  :fecha_inicio,
                  :id,
                  :nombre,
                  :prioridad,
                  :responsable_id,
                  :horas_planeadas,
                  :horas_ejecutadas,
                  :inst_num,
                  :proceso_id,
                  :columna,
                  :hito,
                  :revision_id,
                  :horas_acumuladas ,
                  :activada ,
                  :es_aprobacion,
                  :tarea_revisar_id,
                  :es_desicion,
                  :compuerta_id

  has_many :tarea_recursos, dependent: :destroy
  has_many :recursos, :through => :tarea_recursos

  has_many :tarea_participantes, dependent: :destroy
  has_many :usuarios, :through => :tarea_participantes

  has_many :tarea_artefactos, dependent: :destroy

  has_many :tarea_revisions, dependent: :destroy


end
