class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_answers

  def exp_points
    condition_hash = {
      possible_answers: {
        correct_ans: true
      }
    }
    join_array = [:possible_answer]
    self.user_answers.where(
      condition_hash
    ).includes(
      join_array
    ).sum("exp_points")
  end

  def current_level(game)
    condition_hash = {
      possible_answers: {
        questions:{
          game_levels: {
            game: game
          }
        }
      }
    }
    join_hash = {
        possible_answer:{
          question: :game_level
        }
    }
    self.user_answers.where(
      condition_hash
    ).includes(
      join_hash
    ).first.possible_answer.question.game_level.level||1
  end
end
