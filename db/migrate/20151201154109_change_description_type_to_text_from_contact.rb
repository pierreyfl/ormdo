class ChangeDescriptionTypeToTextFromContact < ActiveRecord::Migration
  def up
    change_column :contacts, :description, :text
  end
  def down
    # This might cause trouble if you have strings longer
    # than 255 characters.
    change_column :contacts, :description, :string
  end
end
