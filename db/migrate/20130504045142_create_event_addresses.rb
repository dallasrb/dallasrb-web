class CreateEventAddresses < ActiveRecord::Migration
  def change
    create_table :event_addresses do |t|
      t.integer :event_id
      t.float :longitude
      t.float :latitude
      t.string :address
      t.string :venue
      t.boolean :gmaps

      t.timestamps
    end
  end
end
