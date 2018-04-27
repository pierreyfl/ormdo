# == Schema Information
#
# Table name: photos
#
#  id                :integer          not null, primary key
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer
#  file_updated_at   :datetime
#  created_at        :datetime
#  updated_at        :datetime
#  main              :boolean          default(FALSE)
#

class Photo < ActiveRecord::Base

  scope :main_photos, -> { where( photos: {main: true}) }
  scope :normal_photos, -> { where.not( photos: {main: true}) }

  has_attached_file :file, :styles => { :medium => "300x300#", :thumb => "100x100#" }
  has_and_belongs_to_many :ads, touch: true
  has_and_belongs_to_many :contacts, touch: true

  validates_attachment_content_type :file, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  before_destroy :update_parents

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
