class Vote < ActiveRecord::Base
  attr_accessible :user_id, :direction

  belongs_to :user
  belongs_to :movie

  validates :direction, inclusion: { in: ["up", "down"] }

  def up?
    direction.eql?("up")
  end

  def down?
    direction.eql?("down")
  end
end
