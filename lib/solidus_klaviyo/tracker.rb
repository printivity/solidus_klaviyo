# frozen_string_literal: true

module SolidusKlaviyo
  class Tracker < SolidusTracking::Tracker
    class << self
      def from_config
        new(api_key: SolidusKlaviyo.configuration.api_key)
      end
    end

    def track(event)
      KlaviyoAPI::Events.create_event({
        type: "event",
        attributes: {
          profile: event.customer_properties,
          metric: {
            name: event.name
          },
          properties: event.properties
        }
      })
    end
  end
end
