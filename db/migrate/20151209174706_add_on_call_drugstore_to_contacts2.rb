class AddOnCallDrugstoreToContacts2 < ActiveRecord::Migration
  def change
    add_column :contacts, :on_call_drugstore, :boolean, default: false
  end
end
