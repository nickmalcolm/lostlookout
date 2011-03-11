class CreateListings < ActiveRecord::Migration
  def self.up
    create_table :listings do |t|
      t.boolean :lost
      t.string :title
      t.string :description
      t.string :longitude
      t.string :latitude
      t.datetime :last_seen_at

      t.timestamps
    end
  end

  def self.down
    drop_table :listings
  end
end
