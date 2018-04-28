class Node < ApplicationRecord
  has_and_belongs_to_many :roles, :dependent => :restrict_with_error

  has_many :macs, :through => :interfaces
  has_many :ip_addrs, :through => :interfaces

  has_many :interfaces, :dependent => :destroy
  has_many :software_apps, :through => :roles
  has_many :comments, :dependent => :destroy

  belongs_to :datacenter
  belongs_to :status
  belongs_to :operating_system

  validates :name, presence: true, length: { minimum: 5 }
  validates :fqdn, presence: true, length: { minimum: 5 }

  validates :datacenter_id, presence: true
  validates :status_id, presence: true
  validates :operating_system_id, presence: true
end
