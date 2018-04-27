class AddAdvertiserToAds < ActiveRecord::Migration
  def change
    add_column :ads, :advertiser, :string
  end
end
