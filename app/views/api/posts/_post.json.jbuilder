# json.extract! post, :id, :video_uri, :description, :audio_name, :audio_uri, :kind, :user, :likes, :comments

json.id post.id
json.video_uri post.video_uri
json.description post.description
json.audio_name post.audio_name
json.audio_uri post.audio_uri
json.kind post.kind
json.user do
    json.username post.user.username
    json.image_uri post.user.user_image.url
end
json.likes do
    post.likes.each do |like|
        json.set! like.user_id do
            json.extract! like, :id
        end
    end
end
# json.comments post.comments
json.comments do 
    json.array! post.comments, partial: "api/comments/comment", as: :comment
end