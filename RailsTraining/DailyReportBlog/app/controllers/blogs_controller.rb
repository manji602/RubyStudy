class BlogsController < ApplicationController
  before_action :signed_in_user

  def new
    unless current_user.blog.nil?
      flash[:warning] = "You have already blog!"
      redirect_to home_path
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = current_user.build_blog(blog_params)

    if @blog.save
      flash[:success] = "Your blog successfully created!"
      redirect_to home_path
    else
      render 'new'
    end
  end

  def destroy
  end

  private
    def blog_params
      params.require(:blog).permit(:title, :description)
    end
end
