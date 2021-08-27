class Post < ApplicationRecord
    belongs_to :user,
        foreign_key: :user_id,
        class_name: :User
        
    has_many :likes, as: :likeable
    has_many :comments, as: :commentable
    has_one_attached :post_video
    has_one_attached :thumbnail

    has_many :post_hashtags
    has_many :hashtags, through: :post_hashtags
    after_commit :create_hashtags, on: :create

    def extract_hashtags
        self.description.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
    end

    def create_hashtags
        extract_hashtags.each do |hashtag|
            @hashtag = Hashtag.find_by(name: hashtag)
            if @hashtag
                PostHashtag.create!(post_id: self.id, hashtag_id: @hashtag.id)
            else
                self.hashtags.create(name: hashtag)
            end
        end
    end
end
