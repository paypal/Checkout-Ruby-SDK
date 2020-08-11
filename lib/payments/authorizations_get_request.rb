# This class was generated on Mon, 27 Aug 2018 13:52:18 PDT by version 0.1.0-dev+904328-dirty of Braintree SDK Generator
# authorizations_get_request.rb
# @version 0.1.0-dev+904328-dirty
# @type request
# @data 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
# DO NOT EDIT
require 'cgi'

module PayPalCheckoutSdk
    module Payments

      #
      # Shows details for an authorized payment, by ID.
      #
      class AuthorizationsGetRequest
        attr_accessor :path, :body, :headers, :verb

        def initialize(authorization_id)
          @headers = {}
          @body = nil
          @verb = "GET"
          @path = "/v2/payments/authorizations/{authorization_id}?"

          @path = @path.gsub("{authorization_id}", CGI::escape(authorization_id.to_s))
          @headers["Content-Type"] = "application/json"
        end
      end
    end
end
