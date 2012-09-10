class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags, :force => true do |t|
      t.string :name
      t.timestamps
    end
    add_index :tags, :name, :name => :index_find_tag_by_name
  end
end
