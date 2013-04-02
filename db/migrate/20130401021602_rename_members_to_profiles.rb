class RenameMembersToProfiles < ActiveRecord::Migration
  def change
    rename_table :members, :profiles
  end
end
