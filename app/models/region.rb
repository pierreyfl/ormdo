# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  state      :string(255)
#  name       :string(255)
#  deleted_at :datetime
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#  sync_uuid  :string(255)
#  ddd        :string(255)
#

class Region < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user
  has_many :contacts, dependent: :restrict_with_error
  has_many :ads, dependent: :restrict_with_error
  has_attached_file :uploader, :styles => { :medium => "300x300#", :thumb => "100x100#" }

  include Syncable

  validates :name, presence: true, uniqueness_without_deleted: { case_sensitive: false }
  validates :state, presence: true
  validates_attachment_content_type :uploader, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

end
