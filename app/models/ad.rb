# == Schema Information
#
# Table name: ads
#
#  id          :integer          not null, primary key
#  view_type   :integer
#  visit_type  :integer
#  title       :string(255)
#  description :string(255)
#  position    :integer
#  start_date  :datetime
#  end_date    :datetime
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  contact_id  :integer
#  region_id   :integer
#  advertiser  :string(255)
#  keyword     :string(255)
#  sync_uuid   :string(255)
#

class Ad < ActiveRecord::Base
  scope :global_filter, -> (name) { where("advertiser like ?", "%#{name}%")}
  scope :position_filter, -> (position) { send(position.to_sym) }
  scope :end_date_before_filter, -> (date) { where("end_date <= ?", date) }
  scope :start_date_after_filter, -> (date) { where("start_date >= ?", date) }

  enum view_type: [:text, :photo, :sponsorship]
  enum visit_type: [:contact, :external_link]
  enum position: [:menu, :list]

  belongs_to :contact, touch: true
  belongs_to :region
  has_and_belongs_to_many :photos, after_add: :resource_added, after_remove: [Proc.new { |p, d| p.updated_at = Time.now}]
  has_and_belongs_to_many :external_links, after_add: :resource_added, before_remove: [:resource_added, Proc.new { |p, d| p.updated_at = Time.now}]

  accepts_nested_attributes_for :photos, allow_destroy: true, reject_if: :reject_photo?
  accepts_nested_attributes_for :external_links, allow_destroy: true, reject_if: :reject_external_link?
  accepts_nested_attributes_for :contact, reject_if: :reject_contact?

  include Syncable

  validates :view_type, presence: true
  validates :visit_type, presence: true
  validates :position, presence: true
  validates :description, presence: true, if: :text?

  validates_presence_of :external_links, if: :external_link?
  validates_presence_of :contact, if: :contact_or_sponsorship?
  validates_presence_of :photos, if: :photo?

  validates :start_date, date: { after_or_equal_to: Proc.new { Date.today }, on: :create}, if: :start_date_present?
  validates :start_date, date: { before_or_equal_to: :end_date }, if: :start_and_end_present?

  validates :end_date, date: { after_or_equal_to: Proc.new { Date.today }, on: :create}, if: :end_date_present?
  validates :end_date, date: { after_or_equal_to: :start_date, on: :create}, if: :start_and_end_present?

  def start_date_present?
    self.start_date.present?
  end

  def end_date_present?
    self.end_date.present?
  end

  def start_and_end_present?
    start_date_present? && end_date_present?
  end

  def contact_or_sponsorship?
    self.contact? || self.sponsorship?
  end

  def selected_link_provider
    if (selected_external_link.present?)
      return selected_external_link.link_provider
    end
    return nil
  end

  def selected_external_link
    self.external_links.first
  end

  def reject_external_link?
    !self.external_link?
  end

  def reject_contact?
    !self.contact? || self.region.nil?
  end

  def reject_photo?
    !self.photo?
  end

  def self.view_type_attributes_for_select
    view_type_attributes_for_select = view_types.map do |view_type, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.view_types.#{view_type}"), view_type]
    end
    view_type_attributes_for_select.shift
    view_type_attributes_for_select
  end

  def self.position_attributes_for_select
    position_attributes_for_select = positions.map do |position, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.positions.#{position}"), position]
    end
  end

  def self.visit_type_attributes_for_select
    visit_type_attributes_for_select = visit_types.map do |visit_type, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.visit_types.#{visit_type}"), visit_type]
    end
  end

  def resource_added(photo)
    if self.persisted?
      self.touch
      puts "Adicionado".red
    end
  end

end
