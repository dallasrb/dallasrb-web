class AddRsvpToEvents < ActiveRecord::Migration
  def change
    add_column :events, :use_rsvp_system, :boolean
  end
end
