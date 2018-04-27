json.contact do
  json.extract! contact, :id, :sync_uuid
end if contact