class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications, :force => true do |t|
      t.references :user,     :null => false
      t.string     :provider, :null => false
      t.string     :uid,      :null => false

      t.timestamps
    end
  end
end
