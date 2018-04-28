require 'resolv'

class IpAddr < ApplicationRecord
  before_validation :downcase_address

  # FIXME(pob): the `required: false` should be removed. It's only in here because of
  # https://github.com/rails/rails/issues/25198#issuecomment-372894070. Once that is
  # fixed we should remove it because we would otherwise run the risk of creating an
  # interface without a mac address.
  belongs_to :mac, -> { includes :interface }, required: false

  has_one :node, through: :mac

  validates :address, presence: true, uniqueness: true,
    format: { with: Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex) }

  private

  def downcase_address
    self.address.downcase!
  end
end
