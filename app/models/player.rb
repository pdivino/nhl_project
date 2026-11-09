class Player < ApplicationRecord
  belongs_to :team
  has_many :player_follows
  has_many :fans, through: :player_follows

  validates :first_name, :last_name, :position_code, presence: true
  validates :nhl_id, presence: true, uniqueness: true
  validates :sweater_number, numericality: { only_integer: true }, allow_nil: true

  def full_name
    "#{first_name} #{last_name}"
  end
end