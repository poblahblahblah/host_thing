class OperatingSystem < ApplicationRecord
  before_validation :normalize_name
  has_many :nodes, :dependent => :restrict_with_error
  validates :name, uniqueness: {case_sensitive: false}

  private

  def normalize_name
    self.name.try(&:strip!)
  end
end
