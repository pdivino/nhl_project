class TeamsController < ApplicationController
  def index
    @teams = Team.includes(:division).order(points: :desc)
  end

  def show
    @team = Team.find(params[:id])
    @players = @team.players.order(:last_name)
  end
end