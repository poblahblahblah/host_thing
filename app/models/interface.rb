class Interface < ApplicationRecord
  
  belongs_to :node
  has_one :mac, :dependent => :destroy
  has_many :ip_addrs, :through => :macs
  accepts_nested_attributes_for :mac

end
