Refinery::PagesController.class_eval do

    before_filter :get_last_3_blog_posts, :only => [:home]
#    before_filter :initialize_mailinglist, :only => [:home]

    protected

      def get_last_3_blog_posts
        @blog_posts = ::Refinery::Blog::Post.live.limit(3)
      end


end