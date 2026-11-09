class TeamFollow < ApplicationRecord
  belongs_to :fan
  belongs_to :team

  validates :fan_id, presence: true
  validates :team_id, uniqueness: { scope: :fan_id }
end