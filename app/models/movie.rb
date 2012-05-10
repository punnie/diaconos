class Movie < ActiveRecord::Base
  attr_accessor :imdb_ref, :creating_user
  attr_accessible :imdb_ref

  serialize :cast_members, Array
  serialize :director, Array
  serialize :genres, Array

  belongs_to :event
  has_many :votes

  before_validation :parse_imdb_id
  before_create :fetch_data_from_imdb
  after_create :add_first_vote

  validates :imdb_id, presence: true
  validates :imdb_id, uniqueness: { message: "movie already exists in our database of fine celluloids." }
  validates :imdb_id, numericality: { only_integer: true, greater_than: 0, message: "looks fishy." }

  default_scope order("vote_count DESC, title ASC")
  scope :highest_scored, where("vote_count = ?", Movie.maximum(:vote_count))

  def add_first_vote
    first_vote = votes.build(user_id: creating_user.id, direction: "up")
    first_vote.save
  end

  def parse_imdb_id
    if self.new_record?
      self.imdb_id = self.imdb_ref.match(/\d+/){ |m| m.to_s.to_i }
    end
  end

  def fetch_data_from_imdb
    imdb_data = Imdb::Movie.new(self.imdb_id.to_s)

    # if the title is nil, the movie doesn't exist
    # fail silently, just to annoy people
    return false if imdb_data.title.nil?

    self.title = imdb_data.title
    self.cast_members = imdb_data.cast_members
    self.director = imdb_data.director
    self.genres = imdb_data.genres
    self.length = imdb_data.length
    self.mpaa_rating = imdb_data.mpaa_rating
    self.poster = imdb_data.poster
    self.rating = imdb_data.rating
    self.release_date = imdb_data.release_date
    self.tagline = imdb_data.tagline
    self.trailer = imdb_data.trailer_url
    self.rating_votes = imdb_data.votes
    self.year = imdb_data.year
  end

  def self.seen
    Movie.where("event_id IS NOT NULL")
  end

  def self.unseen
    Movie.where("event_id IS NULL")
  end

  def seen?
    not event.nil?
  end

  def vote(direction, user)
    # clever protection against downright smartassery
    return false unless ["up", "down"].include?(direction)
    return false if seen?

    user_vote = votes.find_by_user_id(user.id)

    if(user_vote.nil?)
      user_vote = votes.build(user_id: user.id, direction: direction)
      self.vote_count += 1 if direction.eql?("up")
      self.vote_count -= 1 if direction.eql?("down")

      ActiveRecord::Base.transaction do
        user_vote.save
        save
      end
    else
      # if you already voted you can't do so again
      return false if user_vote.direction.eql?(direction)

      # if you already voted, your previous vote is removed and
      # the new one is applied, which will mean the "twos" instead
      # of "ones" here. you'll eventually figure this out
      self.vote_count += 2 if direction.eql?("up")
      self.vote_count -= 2 if direction.eql?("down")

      ActiveRecord::Base.transaction do
        user_vote.update_attributes(direction: direction)
        save
      end
    end
  end
end
