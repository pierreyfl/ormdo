class CreateExternalLinks < ActiveRecord::Migration
  def change
    create_table :external_links do |t|
      t.string :name
      t.string :link
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
