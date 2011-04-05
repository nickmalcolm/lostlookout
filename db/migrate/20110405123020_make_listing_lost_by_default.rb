class MakeListingLostByDefault < ActiveRecord::Migration
  def self.up
    change_column_default :listings, :lost, true
  end

  def self.down
    change_column_default :listings, :lost, nil
  end
end
