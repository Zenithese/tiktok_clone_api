class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :commentable_type
      t.integer :commentable_id
      t.text :body
      t.integer :user_id

      t.timestamps
    end
    add_index :comments, [:commentable_type, :commentable_id]
    add_index :comments, :user_id
  end
end
