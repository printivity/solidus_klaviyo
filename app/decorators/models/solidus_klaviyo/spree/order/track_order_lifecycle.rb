# frozen_string_literal: true

module SolidusKlaviyo
  module Spree
    module Order
      module TrackOrderLifecycle
        def self.prepended(base)
          base.state_machine.after_transition to: :address, do: :track_started_checkout
          base.state_machine.after_transition to: :complete, do: :track_ordered_product
          base.state_machine.after_transition to: :complete, do: :track_placed_order
          base.state_machine.after_transition to: :canceled, do: :track_cancelled_order
        end

        private

        def track_started_checkout
          SolidusKlaviyo.track_later('started_checkout', order: self)
        end

        def track_ordered_product
          line_items.each do |line_item|
            SolidusKlaviyo.track_later('ordered_product', line_item: line_item)
          end
        end

        def track_placed_order
          SolidusKlaviyo.track_later('placed_order', order: self)
        end

        def track_cancelled_order
          SolidusKlaviyo.track_later('cancelled_order', order: self)
        end
      end
    end
  end
end

Spree::Order.prepend(SolidusKlaviyo::Spree::Order::TrackOrderLifecycle)
