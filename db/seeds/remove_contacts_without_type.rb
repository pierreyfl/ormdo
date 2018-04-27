contacts = Contact.where('contact_type_id is NULL')

contacts.each do |contact|
  phones = contact.phones

  phones.each do |phone|
    phone.really_destroy!
  end

  contact.really_destroy!
end