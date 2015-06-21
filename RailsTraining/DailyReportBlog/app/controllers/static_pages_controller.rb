class StaticPagesController < ApplicationController
  include StaticPagesHelper
  before_action :signed_in_user, only: [:settings]

  def home
    if has_blog?
      @blog = current_blog
    end
  end

  def settings
  end

  def about
  end
end
