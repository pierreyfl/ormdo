json.array!(@contacts) do |contact|
  json.extract! contact, :id, :name, :description, :on_call_drugstore, :search_field,
        :latitude, :longitude, :sync_uuid, :address_for_geocoder,
        :region_id, :address, :helpful,
        :contact_type_ids, :open_24,
        :created_at, :updated_at, :deleted_at


  contact_types = contact.contact_types
  phones = contact.phones
  photos = contact.photos
  external_links = contact.external_links

  if contact_types.present?
    json.contact_types do
      json.array!(contact_types) do |contact_type|
        json.extract! contact_type, :id, :name, :parent_contact_type_id, :deleted_at, :created_at, :updated_at
      end
    end
  end

  json.phones phones do |phone|
    json.extract! phone, :id, :area, :number, :priority, :description, :carrier, :deleted_at
  end

  json.photos do
    json.array!(photos) do |photo|
      json.extract! photo, :id, :created_at, :updated_at
      json.medium photo.file(:medium)
      json.thumb photo.file(:thumb)
      json.original photo.file(:original)
    end
  end

  json.external_links do
    json.array!(external_links) do |external_link|
      json.extract! external_link, :id, :name, :link_type, :link, :deleted_at, :created_at, :updated_at
    end
  end

end