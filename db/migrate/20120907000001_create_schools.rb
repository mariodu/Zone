class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools, :force => true do |t|
      t.string :name

      t.timestamps
    end
  end
end
