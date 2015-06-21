# -*- coding: utf-8 -*-
class EntriesController < ApplicationController
  before_action :signed_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_entry, only: [:edit, :update, :destroy]

  def new
    if current_user.blog.nil?
      flash[:warning] = I18n.t('warning_message.blog_is_empty')
      redirect_to home_path
    else
      @entry = Entry.new
      @current_user = current_user
    end
  end

  def create
    current_blog = current_user.blog
    @entry = current_blog.entries.build(entry_params)

    # TODO
    # 本来ならModelでvalidationすべきなので、後で調べる
    unless current_user.id == @entry.user_id
      flash[:warning] = I18n.t('warning_message.create_entry')
      redirect_to home_path
    else
      if @entry.save
        flash[:success] = I18n.t('success_message.create_entry')
        redirect_to home_path
      else
        render 'new'
      end
    end
  end

  def update
    # TODO
    # 本来ならModelでvalidationすべきなので、後で調べる
    unless current_user.id == @entry.user_id
      flash[:warning] = I18n.t('warning_message.update_entry')
      redirect_to home_path
    else
      if @entry.update(entry_params)
        flash[:success] = I18n.t('success_message.update_entry')
        redirect_to home_path
      else
        render 'edit'
      end
    end
  end

  def destroy
    if @entry.destroy
      flash[:success] = I18n.t('success_message.delete_entry')
      redirect_to home_path
    else
      flash[:warning] = I18n.t('warning_message.delete_entry')
    end
  end

  private
    def entry_params
      params.require(:entry).permit(:title, :body, :user_id)
    end

    def correct_entry
      @entry = Entry.find(params[:id])
      redirect_to(root_path) if @entry.nil?
      redirect_to(root_path) unless @entry.user_id == current_user.id
    end
end
