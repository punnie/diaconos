module UsersHelper
  def icon_for_vote(vote)
    return "icon-plus" if vote.up?
    return "icon-minus" if vote.down?
  end
end
