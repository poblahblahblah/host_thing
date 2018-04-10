class SoftwareApp < ApplicationRecord
  has_and_belongs_to_many :roles, :dependent => :restrict_with_error
end
