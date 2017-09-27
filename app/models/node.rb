class Node < ApplicationRecord
  require 'resolv'

  has_many :comments, dependent: :destroy

  belongs_to :datacenter
  belongs_to :status
  belongs_to :operating_system
  belongs_to :role

  validates :name, presence: true, length: { minimum: 5 }
  validates :fqdn, presence: true, length: { minimum: 5 }

  # make sure management and internal ip addresses are passed and they're
  # both valid ipv4 addresses.
  validates :management_ip_address, presence: true, uniqueness: true,
    format: { with: Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex) }
  validates :internal_ip_address, presence: true, uniqueness: true,
    format: { with: Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex) }

  validates :datacenter_id, presence: true
  validates :status_id, presence: true
  validates :role_id, presence: true
  validates :operating_system_id, presence: true
end
