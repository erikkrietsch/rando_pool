class Season < ActiveRecord::Base
  has_many :weeks
  has_many :characters
end
