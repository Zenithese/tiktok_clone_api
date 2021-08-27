class Hashtag < ApplicationRecord
    validates :name, uniqueness: true
    has_many :post_hashtags
    has_many :posts, through: :post_hashtags

    def posts_ids
        count = 0
        ids = []
        res = {}
        self.posts.each do |post|
            ids << post.id 
            count += 1
        end
        res["ids"] = ids
        res["count"] = count
        res
    end
end
