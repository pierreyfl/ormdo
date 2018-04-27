class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :state
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
