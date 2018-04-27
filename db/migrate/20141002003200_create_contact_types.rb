class CreateContactTypes < ActiveRecord::Migration
  def change
    create_table :contact_types do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
