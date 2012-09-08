class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics, :force => true do |t|
      t.string      :title,        :limit => 64,   :null => false
      t.references  :fonder,       :null => false
      t.text        :content,      :null => false
      t.datetime    :edited_at,    :null => true
      t.timestamps
    end
    add_index :topics, :fonder_id, :name => :index_find_topic_by_fonder_id
  end
end