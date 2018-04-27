class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :region
      t.string :name
      t.string :description
      t.decimal :latitude, precision: 16, scale: 14
      t.decimal :longitude, precision: 16, scale: 14
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
