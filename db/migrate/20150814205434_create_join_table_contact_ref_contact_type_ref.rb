class CreateJoinTableContactRefContactTypeRef < ActiveRecord::Migration
  def change
    create_join_table :contacts, :contact_types do |t|
      t.index [:contact_id, :contact_type_id]
      t.index [:contact_type_id, :contact_id]
    end


    Contact.find_each do |contact|

      contact.contact_type_ids = [contact.contact_type_id]
      contact.save!

    end


  end
end
