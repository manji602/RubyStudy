module CommentsHelper
  def comment_user(comment)
    return User.find_by_id(comment.user_id)
  end
end
