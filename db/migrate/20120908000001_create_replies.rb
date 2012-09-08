class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies, :force => true do |t|
      t.references :user
      t.references :topic
      t.string :content

      t.timestamps
    end
  end
end
