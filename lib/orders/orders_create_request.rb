# This class was generated on Mon, 27 Aug 2018 13:51:59 PDT by version 0.1.0-dev+904328-dirty of Braintree SDK Generator
# orders_create_request.rb
# @version 0.1.0-dev+904328-dirty
# @type request
# @data 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
# DO NOT EDIT
require "cgi"

module PayPalCheckoutSdk
  module Orders
    #
    # Creates an order. Supports only orders with one purchase unit.
    #
    class OrdersCreateRequest
      attr_accessor :path, :body, :headers, :verb

      def initialize
        @headers = {}
        @body = nil
        @verb = "POST"
        @path = "/v2/checkout/orders?"
        @headers["Content-Type"] = "application/json"
      end

      def pay_pal_partner_attribution_id(pay_pal_partner_attribution_id)
        @headers["PayPal-Partner-Attribution-Id"] = pay_pal_partner_attribution_id
      end

      def prefer(prefer)
        @headers["Prefer"] = prefer
      end

      def request_body(order)
        @body = order
      end
    end
  end
end
