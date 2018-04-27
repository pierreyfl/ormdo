# == Schema Information
#
# Table name: contact_types
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  deleted_at             :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  parent_contact_type_id :integer
#

class ContactType < ActiveRecord::Base
  acts_as_paranoid

  # has_many :contacts, dependent: :restrict_with_error

  scope :only_parents, -> { where('ifnull(parent_contact_type_id,0) = 0') }
  scope :without_parents, -> { where('ifnull(parent_contact_type_id,0) <> 0') }

  belongs_to :parent, class_name: 'ContactType', foreign_key: :parent_contact_type_id

  has_and_belongs_to_many :contacts
  has_attached_file :uploader, :styles => { :medium => "300x300#", :thumb => "100x100#" }

  validates :name, presence: true
  validates :parent, presence: true
  validates_attachment_content_type :uploader, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
