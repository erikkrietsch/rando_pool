class Api::CurrentSeasonController < ApiController
  expose(:current_season) { Season.current }
end
