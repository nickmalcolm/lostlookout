class AddAreaToListings < ActiveRecord::Migration
  def self.up
    add_column :listings, :area, :string
  end

  def self.down
    add_column :listings, :area, :string
  end
end
