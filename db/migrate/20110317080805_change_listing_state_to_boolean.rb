class ChangeListingStateToBoolean < ActiveRecord::Migration
  def self.up
    remove_column :listings, :state
    add_column :listings, :is_open, :boolean, :default => 1
  end

  def self.down
    remove_column :listings, :is_open
    add_column :listings, :state, :string, :default => "open"
  end
end
