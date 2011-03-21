class ChangeListingDescriptionTypeToText < ActiveRecord::Migration
  def self.up
    change_column :listings, :description, :text
  end

  def self.down
    change_column :listings, :description, :string
  end
end
