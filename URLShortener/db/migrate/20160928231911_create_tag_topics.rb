class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :title, null: false

      t.timestamps null: false
    end
    add_index :tag_topics, :title, unique: true
  end
end
