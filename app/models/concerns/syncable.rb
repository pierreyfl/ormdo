module Syncable
  require 'securerandom'
  extend ActiveSupport::Concern

  included do
    scope :updated_after_filter, -> (date) { where("updated_at > ?", date) }

    before_create :generate_sync_uuid
  end

  def generate_sync_uuid
    self.sync_uuid = SecureRandom.uuid
  end
end