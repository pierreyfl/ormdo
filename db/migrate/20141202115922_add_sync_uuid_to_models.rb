class AddSyncUuidToModels < ActiveRecord::Migration
  def change
    add_column :ads, :sync_uuid, :string
    add_column :contacts, :sync_uuid, :string
    add_column :regions, :sync_uuid, :string

    @contacts = Contact.all
    @contacts.each do |contact|
      contact.generate_sync_uuid
      contact.save
    end

    @regions = Region.all
    @regions.each do |region|
      region.generate_sync_uuid
      region.save
    end

    @ads = Ad.all
    @ads.each do |ad|
      ad.generate_sync_uuid
      ad.save
    end
  end
end
