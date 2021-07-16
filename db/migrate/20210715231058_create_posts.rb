class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :video_uri, null: false
      t.integer :user_id, null: false
      t.text :description
      t.string :audio_name
      t.string :audio_uri
      t.string :kind

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
