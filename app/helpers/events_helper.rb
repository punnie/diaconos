module EventsHelper
  def vote_disabled?(movie, direction)
    vote = Vote.where("user_id = ? AND movie_id = ?", current_user, movie).first

    logger.info "*"*80
    logger.info "*"*80
    logger.info vote.inspect
    logger.info "*"*80
    logger.info "*"*80

    unless vote.nil?
      return 'disabled' if(vote.direction.eql?(direction))
    end

    return nil
  end
end
