class CreateExternalPhotos < ActiveRecord::Migration
  def self.up
    create_table :external_photos do |t|
      t.integer :listing_id
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :external_photos
  end
end
