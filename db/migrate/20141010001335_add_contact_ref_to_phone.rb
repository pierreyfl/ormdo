class AddContactRefToPhone < ActiveRecord::Migration
  def change
    add_reference :phones, :contact, index: true
  end
end
