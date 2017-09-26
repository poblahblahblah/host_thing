class Node < ApplicationRecord
  has_many :comments, dependent: :destroy

  belongs_to :datacenter
  belongs_to :status

  has_one :operating_system

  validates :name, presence: true, length: { minimum: 5 }
  validates :fqdn, presence: true, length: { minimum: 5 }

  validates :datacenter_id, presence: true
  validates :status_id, presence: true
  validates :operating_system_id, presence: true
end
