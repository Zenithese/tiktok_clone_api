@hashtags.each do |hashtag|
    json.set! hashtag[:name] do
        json.extract! hashtag, :posts, :id
    end
end
