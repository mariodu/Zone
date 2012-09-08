class CreateTagsTopics < ActiveRecord::Migration
  def change
    create_table :tags_topics, :force => true, :id => false do |t|
      t.references :topic, :null => false
      t.references :tag,   :null => false
    end
    add_index :tags_topics, :topic_id, :name => :index_topic_id
    add_index :tags_topics, :tag_id,   :name => :index_tag_id
  end
end
