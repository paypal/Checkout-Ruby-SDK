require "paypalhttp"
require "base64"

module PayPal
  SANDBOXAPI = "https://api.sandbox.paypal.com".freeze
  LIVEAPI = "https://api.paypal.com".freeze
  SANDBOXWEB = "https://sandbox.paypal.com".freeze
  LIVEWEB = "https://paypal.com".freeze

  class PayPalEnvironment < PayPalHttp::Environment
    attr_accessor :client_id, :client_secret, :web_url

    def initialize(client_id, client_secret, base_url, web_url)
      super(base_url)
      @client_id = client_id
      @client_secret = client_secret
      @web_url = web_url
    end

    def authorizationString
      encoded = Base64.strict_encode64("#{@client_id}:#{@client_secret}")
      "Basic #{encoded}"
    end
  end

  class SandboxEnvironment < PayPal::PayPalEnvironment
    def initialize(client_id, client_secret)
      super(client_id, client_secret, PayPal::SANDBOXAPI, PayPal::SANDBOXWEB)
    end
  end

  class LiveEnvironment < PayPal::PayPalEnvironment
    def initialize(client_id, client_secret)
      super(client_id, client_secret, PayPal::LIVEAPI, PayPal::LIVEWEB)
    end
  end
end
