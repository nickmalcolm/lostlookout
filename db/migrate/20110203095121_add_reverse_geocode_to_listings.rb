class AddReverseGeocodeToListings < ActiveRecord::Migration
  def self.up
    add_column :listings, :reverse_geocode, :string
  end

  def self.down
    remove_column :listings, :reverse_geocode
  end
end
