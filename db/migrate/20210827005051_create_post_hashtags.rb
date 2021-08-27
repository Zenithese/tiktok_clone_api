class CreatePostHashtags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_hashtags do |t|
      t.belongs_to :post, index: true
      t.belongs_to :hashtag, index: true

      t.timestamps
    end
  end
end
