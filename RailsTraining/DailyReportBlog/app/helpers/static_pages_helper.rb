# -*- coding: utf-8 -*-
module StaticPagesHelper
  def current_blog_title
    if signed_in? && !current_user.blog.nil? && current_user.blog.valid?
      return current_user.blog.title
    else
      return '日報ブログ'
    end
  end

  def has_blog?
    return false unless signed_in?
    return false if current_user.blog.nil?
    return true
  end
end
