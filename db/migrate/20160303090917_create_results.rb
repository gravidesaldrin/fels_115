class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.references :lesson, index: true, foreign_key: true
      t.references :word, index: true, foreign_key: true
      t.references :word_answer, index: true, foreign_key: true
      t.timestamps null: false
    end
    add_index :results, [:lesson_id, :word_id]
    add_index :results, [:lesson_id, :word_answer_id]
  end
end
