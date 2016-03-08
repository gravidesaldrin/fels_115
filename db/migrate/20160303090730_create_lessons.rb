class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :correct_item
      t.integer :total_item
      t.datetime :finished_time
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.timestamps null: false
    end
    add_index :lessons, [:user_id, :category_id]
  end
end
