class Game < ApplicationRecord
  has_many :users
  belongs_to :user
  has_many :game_levels
  validates :name, presence: true
end