class AddSortOrderToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :sort_order, :integer, :default => 0
  end
end
