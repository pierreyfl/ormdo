# == Schema Information
#
# Table name: external_links
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  link             :string(255)
#  deleted_at       :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  link_provider_id :integer
#  link_type        :integer
#

class ExternalLink < ActiveRecord::Base
  belongs_to :link_provider

  validates :link, presence: true
  validates :link_type, presence: true

  enum link_type: [:facebook, :twitter, :youtube, :instagram, :site, :email, :linkedin, :whatsapp]

  has_and_belongs_to_many :ads, touch: true
  has_and_belongs_to_many :contacts, touch: true

  before_save :update_parents
  before_destroy :update_parents

  def self.link_type_attributes_for_select
    link_type_attributes_for_select = link_types.map do |link_type, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.link_types.#{link_type}"), link_type]
    end
  end

  private
  def update_parents
    self.contacts.each do |contact|
      contact.touch
    end

    self.ads.each do |ad|
      ad.touch
    end

  end
end
