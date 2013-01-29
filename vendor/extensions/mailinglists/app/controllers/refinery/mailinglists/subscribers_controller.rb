require 'net/http'

module Refinery
  module Mailinglists
    class SubscribersController < ::ApplicationController

      def create
        subscriber = Subscriber.find_by_email(params[:subscriber][:email])

        subscribed = false
        unsubscribed = false
        if subscriber.nil?
          @subscriber = Subscriber.new(params[:subscriber])
          if !@subscriber.valid? || @subscriber.spam?
            subscribed = true # ignore spam
          else
            subscribed = subscribe(@subscriber)
            Mailer.notification(@subscriber, request).deliver
          end
        else
            if subscriber.subscribed?
              unsubscribed = unsubscribe(subscriber)
            else
              subscribed = subscribe(subscriber)
            end
            Mailer.notification(subscriber, request).deliver
        end

        if subscribed
          flash[:success] = t('mailinglist_subscription_success', :scope => 'refinery.mailinglists.subscribers')
        else

          if unsubscribed
            flash[:success] = t('mailinglist_unsubscription_success', :scope => 'refinery.mailinglists.subscribers')
          else
            flash[:alert] = t('mailinglist_subscription_error', :scope => 'refinery.mailinglists.subscribers')
          end
        end

        rescue
          logger.warn "There was an error with email (#{params[:subscriber][:email]}). \n#{$!.message}\n"
          flash[:error] = "Houston we have a problem. If problem persist please contact us on email: #{Refinery::Setting.get(:site_email)} ."
        ensure
          redirect_to '/#mailinglist-subscription'
      end

      protected

      def unsubscribe(subscriber)
        subscriber.update_attributes(:subscribed => false)
      end

      def subscribe(subscriber)
        subscriber.update_attributes(:subscribed => true)
      end

    end
  end
end
