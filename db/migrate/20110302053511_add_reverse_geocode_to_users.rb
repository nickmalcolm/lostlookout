class AddReverseGeocodeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :reverse_geocode, :string
  end

  def self.down
    remove_column :users, :reverse_geocode
  end
end
