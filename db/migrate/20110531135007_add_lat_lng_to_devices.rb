class AddLatLngToDevices < ActiveRecord::Migration
  def self.up
    add_column :devices, :latitude, :double
    add_column :devices, :longitude, :double
  end

  def self.down
    remove_column :devices, :longitude
    remove_column :devices, :latitude
  end
end
