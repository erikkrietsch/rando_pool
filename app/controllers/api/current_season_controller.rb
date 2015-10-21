class Api::CurrentSeasonController < ApiController
  expose(:current_season) { Season.order(:id).last }
end
