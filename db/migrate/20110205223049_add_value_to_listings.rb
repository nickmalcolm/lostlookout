class AddValueToListings < ActiveRecord::Migration
  def self.up
    add_column :listings, :value, :float
  end

  def self.down
    remove_column :listings, :value
  end
end
