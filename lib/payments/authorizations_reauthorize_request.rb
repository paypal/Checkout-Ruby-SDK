# This class was generated on Mon, 27 Aug 2018 13:52:18 PDT by version 0.1.0-dev+904328-dirty of Braintree SDK Generator
# authorizations_reauthorize_request.rb
# @version 0.1.0-dev+904328-dirty
# @type request
# @data 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
# DO NOT EDIT
require 'cgi'

module PayPalCheckoutSdk
    module Payments

      #
      # Reauthorizes an authorized PayPal account payment, by ID. To ensure that funds are still available, reauthorize a payment after its initial three-day honor period expires. You can reauthorize a payment only once from days four to 29.<br/><br/>If 30 days have transpired since the date of the original authorization, you must create an authorized payment instead of reauthorizing the original authorized payment.<br/><br/>A reauthorized payment itself has a new honor period of three days.<br/><br/>You can reauthorize an authorized payment once for up to 115% of the original authorized amount, not to exceed an increase of $75 USD.<br/><br/>Supports only the `amount` request parameter.
      #
      class AuthorizationsReauthorizeRequest
        attr_accessor :path, :body, :headers, :verb

        def initialize(authorization_id)
          @headers = {}
          @body = nil
          @verb = "POST"
          @path = "/v2/payments/authorizations/{authorization_id}/reauthorize?"

          @path = @path.gsub("{authorization_id}", CGI::escape(authorization_id.to_s))
          @headers["Content-Type"] = "application/json"
        end

        def pay_pal_request_id(pay_pal_request_id)
          @headers["PayPal-Request-Id"] = pay_pal_request_id
        end

        def prefer(prefer)
          @headers["Prefer"] = prefer
        end

        def request_body(reauthorizeRequest)
          @body = reauthorizeRequest
        end
      end
    end
end
