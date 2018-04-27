class AddCheckboxToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :subscriber, :boolean, default: false
  end
end
