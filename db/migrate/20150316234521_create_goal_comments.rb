class CreateGoalComments < ActiveRecord::Migration
  def change
    create_table :goal_comments do |t|
      t.string :body
      t.integer :goal_id
      t.timestamps null: false
    end
    add_index :goal_comments, :goal_id
  end
end
