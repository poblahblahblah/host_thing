class SoftwareApp < ApplicationRecord
  before_validation :normalize_name

  has_and_belongs_to_many :roles, dependen: :restrict_with_error
  has_many :nodes, through: :roles

  validates :name, uniqueness: {case_sensitive: false}

  private

  def normalize_name
    self.name.try(&:downcase!).try(&:strip!)
  end
end
