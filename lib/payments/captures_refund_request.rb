# This class was generated on Mon, 27 Aug 2018 13:52:18 PDT by version 0.1.0-dev+904328-dirty of Braintree SDK Generator
# captures_refund_request.rb
# @version 0.1.0-dev+904328-dirty
# @type request
# @data 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
# DO NOT EDIT
require 'cgi'

module PayPalCheckoutSdk
    module Payments

      #
      # Refunds a captured payment, by ID. For a full refund, include an empty payload in the JSON request body. For a partial refund, include an <code>amount</code> object in the JSON request body.
      #
      class CapturesRefundRequest
        attr_accessor :path, :body, :headers, :verb

        def initialize(capture_id)
          @headers = {}
          @body = nil
          @verb = "POST"
          @path = "/v2/payments/captures/{capture_id}/refund?"

          @path = @path.gsub("{capture_id}", CGI::escape(capture_id.to_s))
          @headers["Content-Type"] = "application/json"
        end

        def pay_pal_request_id(pay_pal_request_id)
          @headers["PayPal-Request-Id"] = pay_pal_request_id
        end

        def prefer(prefer)
          @headers["Prefer"] = prefer
        end

        def request_body(refundRequest)
          @body = refundRequest
        end
      end
    end
end
