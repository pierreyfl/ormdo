class CreateJoinTableAdExternalLink < ActiveRecord::Migration
  def change
    create_join_table :ads, :external_links do |t|
      t.index [:ad_id, :external_link_id]
      t.index [:external_link_id, :ad_id]
    end
  end
end
