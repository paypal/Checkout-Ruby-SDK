# This class was generated on Mon, 27 Aug 2018 13:52:18 PDT by version 0.1.0-dev+904328-dirty of Braintree SDK Generator
# authorizations_void_request.rb
# @version 0.1.0-dev+904328-dirty
# @type request
# @data H4sIAAAAAAAC/6yTQW/TQBCF7/yK0ZyXukScfIsaUCsENSSqhFCFJt5JvXSzu8yOI0yU/47WMdCUckDiZr15Hr1vnr3Hd7RlrJF67aK476Quhny2i86iwQXnVlwqGtZ4E53NBqJAS6Flnw1QgJ9vsoVEw5aDGlgPcLU4g4+xL9YQFcrCp92gHSl0lGHNHGDTez9AS0l7YXuGBt/3LENDQltWloz1p1uDl0yW5UTd42pIhSWruHCHBm9IHK09T4zzh4xo8A0Pf5mccs/blnMGjfcln8Tt9MjBpuiCQrV7UcVCNqvGSUk9F6HhGOjc4Acmex38gPWGfOYifO2dsMVapWeDjcTEoo4z1qH3/nBr8HWU7WPuhrT7N+qTZj+Ptf4G/4N11TE0NDTkn99xYCFlC1cL2EQB7fjJ/uLY7n+CLh7OelxSxCLlFEPmh9pFDMphsiGl5F07ElZf8ljhpWp6y9pFizU218sVHo+HNVa7WTWFz9Xph1/tH5/rUE3/wvLepV8kr74lbpXtUkn7fBEtYz07f3l49gMAAP//
# DO NOT EDIT
require 'cgi'

module PayPalCheckoutSdk
    module Payments

      #
      # Voids, or cancels, an authorized payment, by ID. You cannot void an authorized payment that has been fully captured.
      #
      class AuthorizationsVoidRequest
        attr_accessor :path, :body, :headers, :verb

        def initialize(authorization_id)
          @headers = {}
          @body = nil
          @verb = "POST"
          @path = "/v2/payments/authorizations/{authorization_id}/void?"

          @path = @path.gsub("{authorization_id}", CGI::escape(authorization_id.to_s))
          @headers["Content-Type"] = "application/json"
        end
      end
    end
end
