class StaticPagesController < ApplicationController
  before_action :signed_in_user, only: [:settings]
  def home
  end

  def settings
  end

  def about
  end
end
