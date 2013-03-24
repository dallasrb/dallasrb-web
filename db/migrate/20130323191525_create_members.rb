class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.text :blurb
      t.string :twitter
      t.string :github
      t.string :email
      t.string :homepage
      t.boolean :organizer

      t.timestamps
    end
  end
end
