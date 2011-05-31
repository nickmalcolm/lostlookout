class AddMobileLookoutsToListings < ActiveRecord::Migration
  def self.up
    add_column :listings, :mobile_lookout_count, :integer, :default => 0
  end

  def self.down
    remove_column :listings, :mobile_lookout_count
  end
end
