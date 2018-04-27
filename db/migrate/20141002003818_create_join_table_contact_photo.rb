class CreateJoinTableContactPhoto < ActiveRecord::Migration
  def change
    create_join_table :contacts, :photos do |t|
      t.index [:contact_id, :photo_id]
      t.index [:photo_id, :contact_id]
    end
  end
end
