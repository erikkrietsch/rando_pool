class Api::TeamsController < ApplicationController
  expose(:teams) { Team.all }
end
