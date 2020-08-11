require 'paypalhttp'
require './lib/paypal-checkout-sdk'

module TestHarness
  class << self
    def environment
      client_id = ENV['PAYPAL_CLIENT_ID'] || '<<PAYPAL-CLIENT-ID>>'
      client_secret = ENV['PAYPAL_CLIENT_SECRET'] || '<<PAYPAL-CLIENT-SECRET>>'

      PayPal::SandboxEnvironment.new(client_id, client_secret)
    end

    def client
      PayPal::PayPalHttpClient.new(self.environment)
    end

    def exec(req, body = nil)
      if body
        req.request_body(body)
      end

      client.execute(req)
    end
  end
end
