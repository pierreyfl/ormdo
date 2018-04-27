class AddMainToPhotos3 < ActiveRecord::Migration
  def up
    add_column :photos, :main, :boolean, default: false
    contacts = Contact.all
    contacts.each do |contact|
      if contact.photos.presence
        photo = contact.photos.first
        photo.main = true
        puts photo.save!
      end
    end
  end
  def down
    remove_column :photos, :main, :boolean, default: false

  end
end
