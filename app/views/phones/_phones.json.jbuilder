json.phones phones do |phone|
  json.extract! phone, :id, :area, :number, :priority, :description, :carrier, :deleted_at
end