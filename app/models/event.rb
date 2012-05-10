class Event < ActiveRecord::Base
  attr_accessible :day

  has_one :movie, dependent: :nullify

  validates :day, presence: true
  validates :day, uniqueness: true

  default_scope order: "day ASC"

  def self.next
    Event.where("day >= ? AND status = ?", Date.today, "unspoken").order("day ASC").first
  end

  def self.previous
    Event.where("day < ? AND status = ?", Date.today, "eye-goggled").order("day DESC").first
  end

  def self.last?
    Event.order("day ASC").last
  end

  def see(movie)
    return false if movie.nil?

    ActiveRecord::Base.transaction do
      self.status = "eye-goggled"
      self.movie = movie
      save
    end
  end
end
