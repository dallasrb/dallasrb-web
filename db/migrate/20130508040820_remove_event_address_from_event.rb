class RemoveEventAddressFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :venue
    remove_column :events, :address
    remove_column :events, :latitude
    remove_column :events, :longitude
    remove_column :events, :gmaps
  end
end
