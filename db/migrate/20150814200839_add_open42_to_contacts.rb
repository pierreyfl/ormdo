class AddOpen42ToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :open_24, :boolean, default: false
  end
end
