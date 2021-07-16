class Post < ApplicationRecord
    belongs_to :user,
        foreign_key: :user_id,
        class_name: :User
        
    has_many :likes, as: :likeable
    has_many :comments, as: :commentable
end
