class User < ActiveRecord::Base
  attr_accessible :username, :email

  has_many :votes
  has_many :choices, through: :votes

  validates :username, :email, presence: true
end
