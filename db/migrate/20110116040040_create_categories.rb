class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :listing_categories do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :listing_categories
  end
end
