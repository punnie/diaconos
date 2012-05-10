class Movie < ActiveRecord::Base
  attr_accessor :imdb_ref
  attr_accessible :imdb_ref

  serialize :cast_members, Array
  serialize :director, Array
  serialize :genres, Array

  before_validation :parse_imdb_id
  before_save :fetch_data_from_imdb

  validates :imdb_id, presence: true
  validates :imdb_id, uniqueness: { message: "movie already exists in our database of fine celluloids." }
  validates :imdb_id, numericality: { :only_integer => true, :greater_than => 0 }

  def parse_imdb_id
    self.imdb_id = self.imdb_ref.match(/\d+/){ |m| m.to_s.to_i }
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
    self.votes = imdb_data.votes
    self.year = imdb_data.year
  end
end
