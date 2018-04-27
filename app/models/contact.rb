# == Schema Information
#
# Table name: contacts
#
#  id                   :integer          not null, primary key
#  region_id            :integer
#  name                 :string(255)
#  description          :text(65535)
#  latitude             :decimal(9, 6)
#  longitude            :decimal(9, 6)
#  deleted_at           :datetime
#  created_at           :datetime
#  updated_at           :datetime
#  contact_type_id      :integer
#  sponsorship_id       :integer
#  address              :text(65535)
#  helpful              :boolean          default(FALSE)
#  sync_uuid            :string(255)
#  open_24              :boolean          default(FALSE)
#  search_field         :text(65535)
#  address_for_geocoder :text(65535)
#  on_call_drugstore    :boolean          default(FALSE)
#

require 'csv'

class Contact < ActiveRecord::Base
  scope :global_filter, -> (name) { where("contacts.name like ? or contacts.description like ? or contacts.search_field like ?", "%#{name}%", "%#{name}%", "%#{name}%")}
  scope :region_filter, -> (region_id) { where region_id: region_id }
  scope :contact_type_filter, -> (contact_type_id) { joins(:contact_types).where contact_types_contacts: {contact_type_id: contact_type_id} }


  acts_as_paranoid

  belongs_to :region
  # belongs_to :contact_type

  has_and_belongs_to_many :photos, after_add: :resource_added, after_remove: [Proc.new { |p, d| p.updated_at = Time.now}]
  has_and_belongs_to_many :external_links, after_add: :resource_added, before_remove: [:resource_added, Proc.new { |p, d| p.updated_at = Time.now}]
  has_and_belongs_to_many :contact_types

  has_many :phones
  has_many :ads

  accepts_nested_attributes_for :photos, allow_destroy: true
  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :external_links, allow_destroy: true, reject_if: proc { |attributes| attributes['link'].blank? }

  include Syncable

  validates :name, presence: true
  validates :region, presence: true
  # validates :contact_type, presence: true

  validates_presence_of :phones

  after_save :calculate_geoposition

  def resource_added(photo)
    if self.persisted?
      self.touch
      puts "Adicionado".red
    end
  end

  private
  def calculate_geoposition
    if self.address_for_geocoder_changed? || region_id_changed?
      self.delay.invoke_geocoder(self)
    end
  end

  def invoke_geocoder(contact)
    full_address = ""
    if (contact.address_for_geocoder.present?)
      full_address = self.address_for_geocoder
    end

    geocoded = Geocoder.search(full_address)

    if (geocoded.present?)
      most_accurate = geocoded.first
      contact.latitude = most_accurate.latitude
      contact.longitude = most_accurate.longitude
    else
      contact.latitude = nil
      contact.longitude = nil
    end

    contact.save
  end

  def self.import(file, region)
    file_text = file.read
    file_text = file_text.force_encoding("utf-8")
    errors = parse_spreadsheet(file_text, region)
  end

  def self.parse_spreadsheet(file_text, region)
    n = 0
    header = nil
    errors = []
    contacts = []

    CSV.parse(file_text) do |row|
      n += 1
      if (n == 1)
        header = row
        next
      end
      if (row.join.blank?)
        next
      end

      transposed_row = Hash[[header, row].transpose]

      contact = Contact.build_from_csv(transposed_row)
      contact.region = region

      if contact.valid?
        contacts.push(contact)
      else
        errors << row
      end

      if (n % 1000 == 0)
        Contact.perform_transaction(contacts)
        contacts = []
      end

    end

    Contact.perform_transaction(contacts)

    return errors
  end

  def self.perform_transaction(contacts)
    Contact.transaction do
      contacts.each(&:save!)
    end
  end

  def self.build_from_csv(csv)
    contact = Contact.new
    contact.name = csv["nome"]
    contact.address = csv["endereco"]

    phone1 = csv["telefone1"]
    phone2 = csv["telefone2"]
    phone3 = csv["telefone3"]
    phone4 = csv["telefone4"]

    carrier1 = csv["operadora1"]
    carrier2 = csv["operadora2"]
    carrier3 = csv["operadora3"]
    carrier4 = csv["operadora4"]

    phone = nil

    if (phone1.present?)
      phone = Phone.new
      phone.number = phone1.gsub(/\D/, '').to_i
      phone.carrier = carrier1
      contact.phones << phone
    end

    if (phone2.present?)
      phone = Phone.new
      phone.number = phone2.gsub(/\D/, '').to_i
      phone.carrier = carrier2
      contact.phones << phone
    end

    if (phone3.present?)
      phone = Phone.new
      phone.number = phone3.gsub(/\D/, '').to_i
      phone.carrier = carrier3
      contact.phones << phone
    end

    if (phone4.present?)
      phone = Phone.new
      phone.number = phone4.gsub(/\D/, '').to_i
      phone.carrier = carrier4
      contact.phones << phone
    end
    return contact
  end
end
