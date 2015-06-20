# -*- coding: utf-8 -*-
module StaticPagesHelper
  def current_blog_title
    return has_blog? ? current_user.blog.title : '日報ブログ'
  end

  def current_blog
    return nil unless has_blog?
    return current_user.blog
  end

  def has_blog?
    return false unless signed_in?
    return false if current_user.blog.nil?
    return false unless current_user.blog.valid?
    return true
  end
end
