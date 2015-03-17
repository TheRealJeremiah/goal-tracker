class CreateUserComments < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.string :body
      t.integer :user_id
      t.timestamps null: false
    end
    add_index :user_comments, :user_id
  end
end
