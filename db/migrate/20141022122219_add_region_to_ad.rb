class AddRegionToAd < ActiveRecord::Migration
  def change
    add_reference :ads, :region, index: true
  end
end
