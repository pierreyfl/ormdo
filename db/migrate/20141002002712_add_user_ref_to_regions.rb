class AddUserRefToRegions < ActiveRecord::Migration
  def change
    add_reference :regions, :user, index: true
  end
end
