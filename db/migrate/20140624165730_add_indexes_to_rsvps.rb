class AddIndexesToRsvps < ActiveRecord::Migration
  def change
    add_index :rsvps, :user_id
    add_index :rsvps, :event_id
  end
end
