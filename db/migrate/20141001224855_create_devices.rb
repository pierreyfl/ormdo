class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.references :user, index: true
      t.string :platform
      t.string :register
      t.string :authentication_token, unique: true, null: false

      t.timestamps
    end
    add_index :devices, :authentication_token, unique: true
  end
end
