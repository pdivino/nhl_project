class Team < ApplicationRecord
  belongs_to :division
  has_many :players
  has_many :team_follows
  has_many :fans, through: :team_follows

  validates :name, presence: true, uniqueness: true
  validates :abbrev, presence: true, length: { is: 3 }
  validates :wins, :losses, :points, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end