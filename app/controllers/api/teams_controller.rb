class Api::TeamsController < ApiController
  expose(:teams) { Team.all }
end
