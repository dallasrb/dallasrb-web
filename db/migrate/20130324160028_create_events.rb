class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :event_type_id
      t.datetime :event_date
      t.string :speaker
      t.string :title
      t.text :description
      t.string :slug
      t.string :rsvp_url
      t.string :address
      t.float :latitude
      t.float :longitude
      t.boolean :featured

      t.timestamps
    end

    add_index :events, :slug

  end
end
