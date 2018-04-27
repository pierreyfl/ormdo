class AddSponsorshipIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :sponsorship_id, :integer
  end
end
