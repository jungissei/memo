class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :question
      t.text :answer
      t.references :user, foreign_key: true
      t.integer :num_answer
      t.integer :num_correct
      t.datetime :next_time
      t.integer :before_answer

      t.timestamps
    end
  end
end
