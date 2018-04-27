class AddUploaderToContactType < ActiveRecord::Migration
  def up
    add_attachment :contact_types, :uploader
  end
  
  def down
    remove_attachment :contact_types, :uploader
  end
end
