class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.microposts.build if logged_in?
  end
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
end