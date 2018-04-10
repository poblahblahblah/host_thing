class Role < ApplicationRecord
  has_and_belongs_to_many :nodes, :dependent => :restrict_with_error
  has_and_belongs_to_many :software_apps, :dependent => :restrict_with_error
end
