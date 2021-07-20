class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :recipient_id
      t.integer :actor_id
      t.string :action
      t.datetime :read_at
      t.string :notifiable_type
      t.integer :notifiable_id

      t.timestamps
    end
  end
end
