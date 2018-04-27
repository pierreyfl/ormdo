class AddAddressForGeocoderToContacts2 < ActiveRecord::Migration
  def change
    add_column :contacts, :address_for_geocoder, :text
  end
end
