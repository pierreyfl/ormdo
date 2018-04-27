# == Schema Information
#
# Table name: devices
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  platform             :string(255)
#  register             :string(255)
#  authentication_token :string(255)      not null
#  created_at           :datetime
#  updated_at           :datetime
#

class Device < ActiveRecord::Base
  belongs_to :user

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless Device.where(authentication_token: token).first
    end
  end

end
