class AddUrlsToExternalPhoto < ActiveRecord::Migration
  def self.up
    rename_column :external_photos, :url, :raw_url
    add_column :external_photos, :large_url, :string
    add_column :external_photos, :medium_url, :string
    add_column :external_photos, :small_url, :string
  end

  def self.down
    rename_column :external_photos, :raw_url, :url
    remove_column :external_photos, :small_url
    remove_column :external_photos, :medium_url
    remove_column :external_photos, :large_url
  end
end
