class AddHelpfulToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :helpful, :boolean, :default => false
  end
end
