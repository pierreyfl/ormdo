class CreateLinkProviders < ActiveRecord::Migration
  def change
    create_table :link_providers do |t|
      t.string :name

      t.timestamps
    end
  end
end
