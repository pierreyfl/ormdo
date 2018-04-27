class AddContactIdToAds < ActiveRecord::Migration
  def change
    add_column :ads, :contact_id, :integer
  end
end
