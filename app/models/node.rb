class Node < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  before_validation :normalize_name
  before_validation :normalize_fqdn

  has_and_belongs_to_many :roles, :dependent => :restrict_with_error

  has_many :macs, :through => :interfaces
  has_many :ip_addrs, :through => :interfaces

  has_many :interfaces, :dependent => :destroy
  has_many :software_apps, :through => :roles
  has_many :comments, :dependent => :destroy

  belongs_to :datacenter
  belongs_to :status
  belongs_to :operating_system

  validates :name, presence: true, length: { minimum: 5 }, uniqueness: {case_sensitive: false}
  validates :fqdn, presence: true, length: { minimum: 5 }, uniqueness: {case_sensitive: false}
  validates :serial, presence: true, uniqueness: {case_sensitive: false}

  validates :datacenter_id, presence: true
  validates :status_id, presence: true
  validates :operating_system_id, presence: true

  private
  def normalize_name
    self.name.try(&:downcase!).try(&:strip!)
  end
  def normalize_fqdn
    self.fqdn.try(&:downcase!).try(&:strip!)
  end
end
