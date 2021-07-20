json.id @notification.id
json.actor @notification.actor.username
json.action @notification.action
json.readAt @notification.read_at
json.notifiable do
    json.type "your #{@notification.notifiable.class.name.downcase}"
end