VALID_NAME = /\w/
class Rutum < ActiveRecord::Base
  belongs_to :plantilla, :foreign_key => 'plantilla_id'
  belongs_to :proceso,  :foreign_key => 'proceso_id'
  belongs_to :my_js_tree,  :foreign_key => 'my_js_tree_id'
  attr_accessible :descripcion, :nombre, :tipo, :plantilla_id, :my_js_tree_id, :proceso_id
  self.primary_key = 'id'

   validates :nombre, :presence => true , format: { with:VALID_NAME }, :length => { :maximum => 140 }
   validates :tipo, :presence => true
end
