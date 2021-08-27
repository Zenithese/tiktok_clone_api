@hashtags.each do |hashtag|
    json.set! hashtag[:name] do
        json.extract! hashtag, :posts_ids
    end
end
