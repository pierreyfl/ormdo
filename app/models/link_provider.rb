# == Schema Information
#
# Table name: link_providers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class LinkProvider < ActiveRecord::Base
end
