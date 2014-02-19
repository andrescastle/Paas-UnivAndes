class ProyectoUsuario < ActiveRecord::Base
  belongs_to :proyecto, :foreign_key => 'proyecto_id'
  belongs_to :usuario, :foreign_key => 'usuario_id'
  attr_accessible :proyecto_id, :usuario_id
end
