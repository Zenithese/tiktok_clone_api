class Hashtag < ApplicationRecord
    validates :name, uniqueness: true
    has_many :post_hashtags
    has_many :posts, through: :post_hashtags
end
