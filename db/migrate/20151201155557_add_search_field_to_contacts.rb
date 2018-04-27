class AddSearchFieldToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :search_field, :text
  end
end
