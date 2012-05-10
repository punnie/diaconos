class Event < ActiveRecord::Base
  attr_accessible :day

  has_many :choices, dependent: :destroy
  has_many :movies, through: :choices

  validates :day, presence: true
  validates :day, uniqueness: true

  default_scope order: "day ASC"

  def available_movies
    Movie.all - self.movies
  end
end
