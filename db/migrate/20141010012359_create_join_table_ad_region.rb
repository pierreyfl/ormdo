class CreateJoinTableAdRegion < ActiveRecord::Migration
  def change
    create_join_table :ads, :regions do |t|
      t.index [:ad_id, :region_id]
      t.index [:region_id, :ad_id]
    end
  end
end
