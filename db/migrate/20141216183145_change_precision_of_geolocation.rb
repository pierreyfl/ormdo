class ChangePrecisionOfGeolocation < ActiveRecord::Migration
  def change
    change_column :contacts, :latitude, :decimal, scale: 6, precision: 9
    change_column :contacts, :longitude, :decimal, scale: 6, precision: 9
  end
end
