# ContactType.update_all(parent_contact_type_id: 1009)
#
# ContactType.find_or_create_by(id: 1001, :name => 'Saúde', parent_contact_type_id: 1009)
# ContactType.find_or_create_by(id: 1002, :name => 'Serviços Comerciais', parent_contact_type_id: 1009)
# ContactType.find_or_create_by(id: 1003, :name => 'Comércio', parent_contact_type_id: 1009)
# ContactType.find_or_create_by(id: 1004, :name => 'Alimentação e Festas', parent_contact_type_id: 1009)
# ContactType.find_or_create_by(id: 1005, :name => 'Serviços', parent_contact_type_id: 1009)
# ContactType.find_or_create_by(id: 1006, :name => 'Construção e Decoração', parent_contact_type_id: 1009)
# ContactType.find_or_create_by(id: 1007, :name => 'Lazer e Turismo', parent_contact_type_id: 1009)
# ContactType.find_or_create_by(id: 1008, :name => 'Veículos', parent_contact_type_id: 1009)
# ContactType.find_or_create_by(id: 1009, :name => 'Outros', parent_contact_type_id: 1009)
# ContactType.find_or_create_by(id: 1010, :name => 'Telefones Úteis', parent_contact_type_id: 1009)
#

unless ContactType.exists?(name: 'Outros')
  ct = ContactType.new(id: 1009, :name => 'Outros')
  ct.save(validate: false)
end

unless ContactType.exists?(name: 'Saúde')
  ct = ContactType.new(id: 1001, :name => 'Saúde')
  ct.save(validate: false)
end

unless ContactType.exists?(name: 'Serviços Comerciais')
  ct = ContactType.new(id: 1002, :name => 'Serviços Comerciais')
  ct.save(validate: false)
end

unless ContactType.exists?(name: 'Comércio')
  ct = ContactType.new(id: 1003, :name => 'Comércio')
  ct.save(validate: false)
end

unless ContactType.exists?(name: 'Alimentação e Festas')
  ct = ContactType.new(id: 1004, :name => 'Alimentação e Festas')
  ct.save(validate: false)
end

unless ContactType.exists?(name: 'Serviços')
  ct = ContactType.new(id: 1005, :name => 'Serviços')
  ct.save(validate: false)
end

unless ContactType.exists?(name: 'Construção e Decoração')
  ct = ContactType.new(id: 1006, :name => 'Construção e Decoração')
  ct.save(validate: false)
end

unless ContactType.exists?(name: 'Lazer e Turismo')
  ct = ContactType.new(id: 1007, :name => 'Lazer e Turismo')
  ct.save(validate: false)
end

unless ContactType.exists?(name: 'Veículos')
  ct = ContactType.new(id: 1008, :name => 'Veículos')
  ct.save(validate: false)
end

unless ContactType.exists?(name: 'Telefones Úteis')
  ct = ContactType.new(id: 1010, :name => 'Telefones Úteis')
  ct.save(validate: false)
end

# ContactType.update_all(parent_contact_type_id: 1009)
