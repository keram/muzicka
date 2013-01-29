module Refinery
  module Mailinglists
    class Mailer < ActionMailer::Base

      def notification(subscriber, request)
        @subscriber = subscriber
        mail :subject  => Refinery::Mailinglists::Setting.notification_subject,
             :to       => Refinery::Mailinglists::Setting.notification_recipients,
             :from     => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>"
      end

    end
  end
end
