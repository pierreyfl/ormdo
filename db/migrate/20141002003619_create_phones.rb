class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :area
      t.string :number
      t.float :priority
      t.string :description
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
