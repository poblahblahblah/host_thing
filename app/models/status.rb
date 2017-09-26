class Status < ApplicationRecord
  has_many :nodes, :dependent => :restrict_with_error
end
