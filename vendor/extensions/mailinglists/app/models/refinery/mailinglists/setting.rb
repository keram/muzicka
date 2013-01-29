module Refinery
  module Mailinglists
    class Setting < Refinery::Core::BaseModel

      class << self

        def notification_recipients
          Refinery::Setting.find_or_set(:mailinglist_notification_recipients,
                                        (Role[:refinery].users.first.try(:email) if defined?(Role)).to_s)
        end

        def notification_subject
          Refinery::Setting.find_or_set(:mailinglist_notification_subject,
                                        "New mailinglist subscription")
        end
      end

    end
  end
end
