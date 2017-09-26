class Datacenter < ApplicationRecord
  has_many :nodes, :dependent => :restrict_with_error

  validates :name, presence: true, length: { minimum: 2 }
  validates :vendor, presence: true, length: { minimum: 5 }
  validates :provider, presence: true, length: { minimum: 5 }
end
