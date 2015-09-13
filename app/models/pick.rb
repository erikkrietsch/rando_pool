class Pick < ActiveRecord::Base
  belongs_to :character
  belongs_to :week
  belongs_to :team
end
