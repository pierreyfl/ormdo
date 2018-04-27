class AddDddToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :ddd, :string, length: 3
  end
end
