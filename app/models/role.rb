class Role < ApplicationRecord
  has_and_belongs_to_many :nodes, :dependent => :restrict_with_error
end
