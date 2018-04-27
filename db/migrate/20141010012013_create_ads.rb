class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.integer :view_type
      t.integer :visit_type
      t.string :title
      t.string :description
      t.float :position
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
