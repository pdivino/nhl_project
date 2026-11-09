class DivisionsController < ApplicationController
  def index
    @divisions = Division.order(:conference, :name)
  end

  def show
    @division = Division.find(params[:id])
    @teams = @division.teams.order(points: :desc)
  end
end