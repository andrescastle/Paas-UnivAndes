class Deposito < ActiveRecord::Base
  belongs_to :tipo_deposito, :foreign_key => 'tipo_deposito_id'
  has_many :deposito_proyectos, dependent: :destroy
  has_many :proyectos, :through => :deposito_proyectos
  has_many :archivos
  attr_accessible :contrasena, :fcreado, :nombre, :usuario, :id, :tipo_deposito_id, :tipo_deposito, :descripcion, :cuenta
   self.primary_key = 'id'
  validates_confirmation_of :contrasena
  validates :tipo_deposito, :presence => true
  validates :nombre, :presence => true

end
