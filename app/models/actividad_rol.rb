class ActividadRol < ActiveRecord::Base
  belongs_to :actividad, :foreign_key => 'actividad_id'
  belongs_to :rol, :foreign_key => 'rol_id'

  attr_accessible :actividad_id, :id, :rol_id

  validates :actividad, :presence => true
  validates :rol, :presence => true
end
