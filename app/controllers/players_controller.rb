class PlayersController < ApplicationController
  def index
    @divisions = Division.order(:name)
    @players = Player.includes(:team).order(:last_name)

    if params[:q].present?
      term = "%#{Player.sanitize_sql_like(params[:q])}%"
      @players = @players.where("first_name LIKE ? OR last_name LIKE ?", term, term)
    end

    if params[:division_id].present?
      @players = @players.joins(:team).where(teams: { division_id: params[:division_id] })
    end

    @players = @players.page(params[:page]).per(25)
  end

  def show
    @player = Player.find(params[:id])
  end
end