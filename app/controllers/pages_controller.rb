class PagesController < ApplicationController
  expose(:wins) { Rando.wins }
  expose(:losses) { Rando.losses }
  expose(:ratio) { Rando.ratio }
end
