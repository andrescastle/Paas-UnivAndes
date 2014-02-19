class ProyectoOrganizacion < ActiveRecord::Base
  belongs_to :proyecto, :foreign_key => 'proyecto_id'
  belongs_to :organizacion, :foreign_key => 'organizacion_id'

  attr_accessible :organizacion_id, :proyecto_id

  validates :proyecto, :presence => true
  validates :organizacion, :presence => true
end
