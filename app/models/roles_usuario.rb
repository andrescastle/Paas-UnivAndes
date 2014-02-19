class RolesUsuario < ActiveRecord::Base
  belongs_to :role, :foreign_key => 'role_id'
  belongs_to :usuario, :foreign_key => 'usuario_id'
  attr_accessible :role_id, :usuario_id
end
