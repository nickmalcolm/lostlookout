class RemovePasswordSaltFromUsers < ActiveRecord::Migration
  def self.up
    #Upgrade to Devise 1.2 removes the need for this
    remove_column :users, :password_salt
  end

  def self.down
    add_column :users, :password_salt, :default => "", :null => false
  end
end
