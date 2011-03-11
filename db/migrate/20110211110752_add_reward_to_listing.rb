class AddRewardToListing < ActiveRecord::Migration
  def self.up
    add_column :listings, :reward, :float
  end

  def self.down
    remove_column :listings, :reward
  end
end
