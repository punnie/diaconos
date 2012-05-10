class Choice < ActiveRecord::Base
  attr_accessible :movie_id, :event_id

  belongs_to :movie
  belongs_to :event

  scope :ordered, order("votes DESC")

  def vote(direction)
    self.votes += 1 if direction.eql?("up")
    self.votes -= 1 if direction.eql?("down")
   save
  end
end
