json.extract! user, :id, :username, :session_token, :followings, :followers
json.posts(user.posts) do |post|
    json.partial! "api/posts/post", post: post
end
json.image_uri user.user_image.url