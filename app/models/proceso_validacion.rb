class ProcesoValidacion < ActiveRecord::Base
  attr_accessible :error_message, :proceso_id, :tipo
end
