class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :initialize_mailinglist, :only => [:home]
  before_filter :get_last_3_blog_posts, :only => [:home]

  protected

  def get_last_3_blog_posts
    @blog_posts = ::Refinery::Blog::Post.live.limit(3)
  end

  def initialize_mailinglist
    @subscriber = ::Refinery::Mailinglists::Subscriber.new
  end
end
