class AddTypeToExternalLinks < ActiveRecord::Migration
  def change
    add_column :external_links, :link_type, :integer
  end
end
