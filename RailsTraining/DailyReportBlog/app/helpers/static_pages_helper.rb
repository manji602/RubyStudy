module StaticPagesHelper
  def has_blog?
    return false unless signed_in?
    return false unless current_user.blog.nil?
    return true
  end
end
