# == Schema Information
#
# Table name: phones
#
#  id          :integer          not null, primary key
#  area        :string(255)
#  number      :string(255)
#  priority    :float(24)
#  description :string(255)
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  contact_id  :integer
#  carrier     :integer
#

class Phone < ActiveRecord::Base
  enum carrier: [:tim, :claro, :ctbc_telecom, :oi, :vivo, :sercomtel, :nextel, :gvt]

  belongs_to :contact, touch: true

  validates :number, numericality: { only_integer: true }
  # validates :area, numericality: { only_integer: true, greater_than: 10, less_than: 100 }

  def self.carrier_attributes_for_select
    carrier_attributes_for_select = carriers.map do |carrier, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.carriers.#{carrier}"), carrier]
    end
  end
end
