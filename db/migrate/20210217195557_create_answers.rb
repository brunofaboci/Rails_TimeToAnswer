class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.text :description, null: false
      t.boolean :correct, default: false
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
