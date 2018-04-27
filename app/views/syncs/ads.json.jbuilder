json.array!(@ads) do |ad|
  json.extract! ad, :id, :view_type, :visit_type,
        :title, :description, :position,
        :start_date, :end_date, :deleted_at, :updated_at,
        :created_at, :sync_uuid, :advertiser, :keyword

  if (ad.region.present?)
    json.region_id ad.region.id
    json.partial! 'regions/region', region: ad.region
  end

  json.partial! 'photos/photo', photo: ad.photos.first
  json.partial! 'external_links/external_link', external_link: ad.external_links.first
  json.partial! 'contacts/contact_keys', contact: ad.contact

end