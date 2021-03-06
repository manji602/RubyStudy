class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in @user
      flash[:success] = I18n.t('success_message.create_user')
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    unless @user.blog.nil?
      @entries = @user.blog.entries.paginate(page: params[:page], per_page: 5)
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = I18n.t('success_message.update_user')
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    target_user = User.find(params[:id])
    if current_user.admin? && target_user.id != current_user.id
      target_user.destroy
      flash[:success] = I18n.t('success_message.delete_user')
      redirect_to(users_url)
    else
      flash[:warning] = I18n.t('warning_message.delete_user')
      redirect_to(root_path)
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
