class AddLinkProviderToExternalLinks < ActiveRecord::Migration
  def change
    add_reference :external_links, :link_provider, index: true
  end
end
