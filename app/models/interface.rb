class Interface < ApplicationRecord
  before_validation :normalize_name

  belongs_to :node
  has_one :mac, dependent: :destroy
  has_many :ip_addrs, through: :macs
  accepts_nested_attributes_for :mac

  validates :name, presence: true

  private
  def normalize_name
    self.name.try(&:strip!)
  end
end
