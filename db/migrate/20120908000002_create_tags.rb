class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags, :force => true do |t|
      t.string :name

      t.timestamps
    end
  end
end
