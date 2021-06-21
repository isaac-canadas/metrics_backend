class Metric < ApplicationRecord
  # validations
  validates_presence_of :name, :value
end
