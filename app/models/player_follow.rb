class PlayerFollow < ApplicationRecord
  belongs_to :fan
  belongs_to :player

  validates :fan_id, presence: true
  validates :player_id, uniqueness: { scope: :fan_id }
end