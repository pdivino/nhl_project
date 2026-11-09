# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"
require "json"

puts "Clearing old data..."
PlayerFollow.delete_all
TeamFollow.delete_all
Player.delete_all
Team.delete_all
Division.delete_all
Fan.delete_all

# ---------- SOURCE 1: NHL Standings API (divisions + teams) ----------
puts "Fetching teams from NHL standings API..."
standings = JSON.parse(URI.open("https://api-web.nhle.com/v1/standings/now").read)

standings["standings"].each do |t|
  division = Division.find_or_create_by(name: t["divisionName"], conference: t["conferenceName"])

  team = division.teams.create(
    name:      t["teamName"]["default"],
    abbrev:    t["teamAbbrev"]["default"],
    wins:      t["wins"],
    losses:    t["losses"],
    ot_losses: t["otLosses"],
    points:    t["points"],
    logo_url:  t["teamLogo"]
  )
  puts "Team error: #{team.errors.full_messages}" unless team.persisted?
end

# ---------- SOURCE 2: NHL Roster API (players) ----------
puts "Fetching rosters..."
Team.find_each do |team|
  roster = JSON.parse(URI.open("https://api-web.nhle.com/v1/roster/#{team.abbrev}/current").read)

  (roster["forwards"].to_a + roster["defensemen"].to_a + roster["goalies"].to_a).each do |p|
    player = team.players.create(
      nhl_id:         p["id"],
      first_name:     p["firstName"]["default"],
      last_name:      p["lastName"]["default"],
      sweater_number: p["sweaterNumber"],
      position_code:  p["positionCode"],
      height_inches:  p["heightInInches"],
      weight_pounds:  p["weightInPounds"],
      birth_date:     p["birthDate"],
      birth_country:  p["birthCountry"],
      headshot_url:   p["headshot"]
    )
    puts "Player error: #{player.errors.full_messages}" unless player.persisted?
  end
  puts "  #{team.abbrev}: #{team.players.count} players"
end

# ---------- SOURCE 3: Faker (fans + who they follow) ----------
puts "Creating fake fans..."
teams   = Team.all.to_a
players = Player.all.to_a

100.times do
  fan = Fan.create(
    name:  Faker::Name.name,
    email: Faker::Internet.unique.email,
    city:  Faker::Address.city
  )
  next unless fan.persisted?

  teams.sample(rand(1..3)).each   { |team|   fan.team_follows.create(team: team) }
  players.sample(rand(1..5)).each { |player| fan.player_follows.create(player: player) }
end

puts "Done!"
puts "Divisions: #{Division.count}"
puts "Teams: #{Team.count}"
puts "Players: #{Player.count}"
puts "Fans: #{Fan.count}"
puts "Team follows: #{TeamFollow.count}"
puts "Player follows: #{PlayerFollow.count}"