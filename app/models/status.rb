class Status < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  before_validation :normalize_name

  has_many :nodes, dependent: :restrict_with_error

  validates :name, uniqueness: {case_sensitive: false}

  private

  def normalize_name
    self.name.try(&:downcase!).try(&:strip!)
  end
end
