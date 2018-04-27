class AddCarrierToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :carrier, :integer
  end
end
