class AddUserImageToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :image_uri, :string
  end
end
