if (photo.present?)
  json.photo do
    json.extract! photo, :id, :created_at, :updated_at
    json.medium photo.file(:medium)
    json.thumb photo.file(:thumb)
    json.original photo.file(:original)
  end
end
