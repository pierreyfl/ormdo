if (contact_type.present?)
  json.contact_type do
    json.extract! contact_type, :id, :name, :parent_contact_type_id, :deleted_at, :created_at, :updated_at
  end
end