class RemoveTextFromTopic < ActiveRecord::Migration
  def self.up
    remove_column :topics, :text
  end

  def self.down
    add_column :topics, :text, :string
  end
end
