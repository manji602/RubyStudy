class BlogsController < ApplicationController
  before_action :signed_in_user
  before_action :correct_blog, only: [:edit, :update]

  def new
    unless current_user.blog.nil?
      flash[:warning] = I18n.t('warning_message.create_duplicate_blog')
      redirect_to home_path
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = current_user.build_blog(blog_params)

    if @blog.save
      flash[:success] = I18n.t('success_message.create_blog')
      redirect_to home_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      flash[:success] = I18n.t('success_message.update_blog')
      redirect_to home_path
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
    def blog_params
      params.require(:blog).permit(:title, :description)
    end

    def correct_blog
      @blog = Blog.find(params[:id])
      redirect_to(root_path) if current_user.blog.nil?
      redirect_to(root_path) unless current_user.blog.id == @blog.id
    end
end
