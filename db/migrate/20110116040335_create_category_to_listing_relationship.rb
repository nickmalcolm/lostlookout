class CreateCategoryToListingRelationship < ActiveRecord::Migration
  def self.up
    add_column :listings, :listing_category_id, :integer
  end

  def self.down
    remove_column :listings, :listing_category_id 
  end
end
