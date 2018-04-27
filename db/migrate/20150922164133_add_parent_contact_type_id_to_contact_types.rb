class AddParentContactTypeIdToContactTypes < ActiveRecord::Migration
  def change
    add_reference :contact_types, :parent_contact_type, index: true
  end
end
