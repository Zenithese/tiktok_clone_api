# json.array! @posts, partial: "api/posts/post", as: :post
@posts.each do |post|
    json.set! post.id do
        json.partial! "api/posts/post", post: post
    end
end