class CreateWordAnswers < ActiveRecord::Migration
  def change
    create_table :word_answers do |t|
      t.string :content
      t.boolean :correct, default: false
      t.references :word, index: true, foreign_key: true
      t.timestamps null: false
    end
    add_index :word_answers, [:word_id, :content]
    add_index :word_answers, [:word_id, :content, :correct], unique: true
  end
end
