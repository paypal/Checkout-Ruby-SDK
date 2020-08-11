require "./lib/paypal-checkout-sdk"

module PayPalClient
  class << self
    # Setting up and Returns PayPal SDK environment with PayPal Access credentials.
    # For demo purpose, we are using SandboxEnvironment. In production this will be
    # LiveEnvironment.
    def environment
      client_id = ENV["PAYPAL_CLIENT_ID"] || "<<PAYPAL-CLIENT-ID>>"
      client_secret = ENV["PAYPAL_CLIENT_SECRET"] || "<<PAYPAL-CLIENT-SECRET>>"

      PayPal::SandboxEnvironment.new(client_id, client_secret)
    end

    # Returns PayPal HTTP client instance with environment which has access
    # credentials context. This can be used invoke PayPal API's provided the
    # credentials have the access to do so.
    def client
      PayPal::PayPalHttpClient.new(environment)
    end

    # Utility to convert Openstruct Object to JSON hash.
    def openstruct_to_hash(object, hash = {})
      object.each_pair do |key, value|
        hash[key] = if value.is_a?(OpenStruct)
                      openstruct_to_hash(value)
                    else
                      value.is_a?(Array) ? array_to_hash(value) : value
                    end
      end
      hash
    end

    # Utility to convert Array of OpenStruct into Hash.
    def array_to_hash(array)
      array.each_with_object({}) do |item, acc|
        acc << if item.is_a?(OpenStruct)
                 openstruct_to_hash(item)
               else
                 item.is_a?(Array) ? array_to_hash(item) : item
               end
      end
    end
  end
end
