class ChangePositionTypeInAds < ActiveRecord::Migration
  def up
    change_column :ads, :position, :integer
  end

  def down
    change_column :ads, :position, :float
  end
end
