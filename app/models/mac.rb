class Mac < ApplicationRecord
  before_validation :downcase_address
  before_validation :convert_dashes_to_colons

  belongs_to :interface
  has_many :ip_addrs, dependent: :destroy

  accepts_nested_attributes_for :ip_addrs

  # regex for mac address taken from
  # https://stackoverflow.com/questions/4260467/what-is-a-regular-expression-for-a-mac-address
  validates :address, presence: true, uniqueness: true,
    format: { with: /\A([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})\z/ }

  private

  def downcase_address
    self.address.downcase!
  end

  def convert_dashes_to_colons
    self.address.gsub!('-', ':')
  end
end
