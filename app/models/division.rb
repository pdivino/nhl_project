class Division < ApplicationRecord
  has_many :teams

  validates :name, presence: true, uniqueness: true
  validates :conference, presence: true
end
