class ChangePostTextTypeAndName < ActiveRecord::Migration
  def self.up
    rename_column :posts, :text, :content
    change_column :posts, :content, :text
  end

  def self.down
    change_column :posts, :content, :string
    rename_column :posts, :content, :text
  end
end
