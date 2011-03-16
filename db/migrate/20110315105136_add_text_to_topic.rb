class AddTextToTopic < ActiveRecord::Migration
  def self.up
    add_column :topics, :text, :string
  end

  def self.down
    remove_column :topics, :text
  end
end
