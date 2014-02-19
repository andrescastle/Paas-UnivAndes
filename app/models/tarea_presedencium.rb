class TareaPresedencium < ActiveRecord::Base
  belongs_to :tarea, :foreign_key => 'predecesora_id'
  belongs_to :tarea, :foreign_key => 'sucesora_id'
  belongs_to :proceso, :foreign_key => 'proceso_id'
  attr_accessible :predecesora_id, :sucesora_id, :tipo_relacion, :proceso_id
end
