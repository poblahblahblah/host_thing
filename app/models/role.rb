class Role < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  before_validation :normalize_name

  has_and_belongs_to_many :nodes, dependent: :restrict_with_error
  has_and_belongs_to_many :software_apps, dependent: :restrict_with_error

  validates :name, uniqueness: {case_sensitive: false}

  private

  def normalize_name
    self.name.try(&:downcase!).try(&:strip!)
  end
end
