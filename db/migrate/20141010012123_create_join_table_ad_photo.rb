class CreateJoinTableAdPhoto < ActiveRecord::Migration
  def change
    create_join_table :ads, :photos do |t|
      t.index [:ad_id, :photo_id]
      t.index [:photo_id, :ad_id]
    end
  end
end
