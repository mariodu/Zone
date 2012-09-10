class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies, :force => true do |t|
      t.references :user
      t.references :topic
      t.string :content

      t.timestamps
    end
    add_index :replies, :user_id, :name => :index_find_reply_by_user_id
    add_index :replies, :topic_id, :name => :index_find_reply_by_topic_id
  end
end
