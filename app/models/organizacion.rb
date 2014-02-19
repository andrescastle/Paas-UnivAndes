VALID_NAME = /\w/
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


class Organizacion < ActiveRecord::Base
  belongs_to :organizacions, dependent: :destroy
  belongs_to :tipo_organizacion, :foreign_key => 'tipo_organizacion_id'
  has_many :recursos, dependent: :destroy

  has_many :proyecto_organizacion, dependent: :destroy
  has_many :proyectos, :through => :proyecto_organizacion

  attr_accessible :descripcion, :direccion, :naturaleza, :nit, :nombre, :representante, :telefono, :tipo_organizacion_id
  self.primary_key = 'id'

  #validates :nombre, presence:true, format: { with:VALID_NAME }, :length => { :maximum => 140 }, uniqueness:true
  #validates :descripcion, :length => { :maximum => 255 }
  #validates :nit, presence:true, :length => { :maximum => 10 }
  #validates :direccion, format: { with:VALID_EMAIL_REGEX }
end
