class Role < ActiveRecord::Base
  has_many :roles_usuarios, dependent: :destroy
  has_many  :usuarios, :through => :roles_usuarios

  has_and_belongs_to_many :users
end