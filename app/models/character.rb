class Character < ActiveRecord::Base
  belongs_to :player
  belongs_to :season

  has_many :picks
end
