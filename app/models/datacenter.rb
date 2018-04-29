class Datacenter < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  before_validation :normalize_name

  has_many :nodes, :dependent => :restrict_with_error

  validates :name, presence: true, length: { minimum: 2 }, uniqueness: {case_sensitive: false}
  validates :vendor, presence: true, length: { minimum: 5 }
  validates :provider, presence: true, length: { minimum: 5 }

  private
  def normalize_name
    self.name.try(&:downcase!).try(&:strip!)
  end
end
