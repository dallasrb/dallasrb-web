class MigrateProfileBlurbToString < ActiveRecord::Migration
  def up
    # truncate blurbs to be at most 140 characters long
    Profile.all.each do |profile|
      profile.update_attributes(:blurb => profile.blurb[0..139]) if profile.blurb.present?
    end
    change_column :profiles, :blurb, :string, :limit => 140
  end

  def down
    change_column :profiles, :blurb, :text
  end
end
