class AddUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :encrypted_password,  :string ,:null => false, :default => ""

    ## Recoverable
    add_column :usuarios,:reset_password_token , :string
    add_column  :usuarios,:reset_password_sent_at  , :datetime

    ## Rememberable
    add_column :usuarios, :remember_created_at ,:datetime

    ## Trackable
    add_column :usuarios,  :sign_in_count,:integer, :default => 0
    add_column :usuarios, :current_sign_in_at ,:datetime
    add_column :usuarios, :last_sign_in_at ,:datetime
    add_column :usuarios,   :current_sign_in_ip,:string
    add_column :usuarios,   :last_sign_in_ip ,:string

    add_index :usuarios, :email,                :unique => true
    add_index :usuarios, :reset_password_token, :unique => true
  end

end
