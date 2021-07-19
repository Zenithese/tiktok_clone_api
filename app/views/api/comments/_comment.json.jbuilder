json.id comment.id
json.user_id comment.user_id
json.username comment.user.username
json.commentable_type comment.commentable_type
json.commentable_id comment.commentable_id
json.body comment.body
json.likes do
    comment.likes.each do |like|
        json.set! like.user_id do
            json.extract! like, :id
        end
    end
end
json.comments do 
    json.array! comment.comments, partial: "api/comments/comment", as: :comment
end