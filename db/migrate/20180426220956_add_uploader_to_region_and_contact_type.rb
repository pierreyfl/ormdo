class AddUploaderToRegionAndContactType < ActiveRecord::Migration
  def up
    add_attachment :regions, :uploader
  end
  
  def down
    remove_attachment :regions, :uploader
  end
end
