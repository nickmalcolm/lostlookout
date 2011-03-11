class AddStateToListings < ActiveRecord::Migration
  def self.up
    add_column :listings, :state, :string, :default => "open"
  end

  def self.down
    remove_column :listings, :state
  end
end
