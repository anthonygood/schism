class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.integer :question_id
      t.integer :winner_id
      t.integer :loser_id

      t.timestamps
    end
  end
end
