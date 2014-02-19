class MyJsTree < ActiveRecord::Base
   has_one :actividad, dependent: :destroy
   has_one :compuertu, dependent: :destroy
   has_one :evento, dependent: :destroy
   has_one :rutum, dependent: :destroy
   belongs_to :plantilla, :foreign_key => 'plantilla_id'
   belongs_to :proceso,  :foreign_key => 'proceso_id'

  has_many :hijos, :class_name => "MyJsTree",
    :foreign_key => "MyJsTree_id"
  belongs_to :padre, :class_name => "MyJsTree", dependent: :delete


  self.inheritance_column=:_type_disable
  attr_accessible :left, :level, :parent_id, :position, :right, :title, :type, :plantilla_id, :proceso_id
end
