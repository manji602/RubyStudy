class CommentsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_comment, only: [:destroy]

  def create
    @comment = Comment.create(comment_params)

    if @comment.save
      flash[:success] = I18n.t('success_message.create_comment')
    else
      flash[:warning] = I18n.t('warning_message.create_comment')
    end
    redirect_to :back
  end

  def destroy
    if @comment.destroy
      flash[:success] = I18n.t('success_message.delete_comment')
    else
      flash[:warning] = I18n.t('warning_message.delete_comment')
    end
    redirect_to :back
  end

  private
    def comment_params
      params.require(:comment).permit(:body, :user_id, :entry_id)
    end

    def correct_comment
      @comment = Comment.find(params[:id])
      redirect_to :back if @comment.nil?
      redirect_to :back unless @comment.user_id == current_user.id
    end
end
