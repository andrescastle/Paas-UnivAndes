class Transicion < ActiveRecord::Base
  belongs_to :proceso,  :foreign_key => 'proceso_id'
  attr_accessible :fin_id, :id, :incio_id, :nombre, :proceso_id, :tipo_fin, :tipo_inicio
end
