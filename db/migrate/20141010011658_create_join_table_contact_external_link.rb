class CreateJoinTableContactExternalLink < ActiveRecord::Migration
  def change
    create_join_table :contacts, :external_links do |t|
      t.index [:contact_id, :external_link_id]
      t.index [:external_link_id, :contact_id]
    end
  end
end
