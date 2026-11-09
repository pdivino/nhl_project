class Fan < ApplicationRecord
  has_many :team_follows
  has_many :teams, through: :team_follows
  has_many :player_follows
  has_many :players, through: :player_follows

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end