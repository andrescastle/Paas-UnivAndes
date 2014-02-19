class TipoDeposito < ActiveRecord::Base
  attr_accessible :nombre, :id, :logo
  has_many :depositos, dependent: :destroy
   self.primary_key = 'id'
  validates :nombre, :presence => true
end
