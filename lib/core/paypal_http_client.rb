# frozen_string_literal: true

require 'paypalhttp'
require 'openssl'
require_relative './version'

module PayPal
  class PayPalHttpClient < PayPalHttp::HttpClient

    attr_accessor :refresh_token

    def initialize(environment, refresh_token = nil)
      super(environment)
      @refresh_token = refresh_token

      add_injector(&method(:_sign_request))
      add_injector(&method(:_add_headers))
    end

    def user_agent
      @library_details ||= generate_ua_string
    end

    private

    def generate_ua_string
      parts = ["paypal-checkout-sdk #{VERSION}", "ruby #{RUBY_VERSION}p#{RUBY_PATCHLEVEL}-#{RUBY_PLATFORM}"]

      parts << (OpenSSL.const_defined?('OPENSSL_LIBRARY_VERSION') ? OpenSSL::OPENSSL_LIBRARY_VERSION : "OpenSSL #{OpenSSL::OPENSSL_VERSION}" )

      "PayPalSDK/rest-sdk-ruby #{VERSION} (#{parts.join('; ')})"
    end

    def _sign_request(request)
      return if _has_auth_header(request) && _is_auth_request(request)

      if !@access_token || @access_token.isExpired
        accessTokenRequest = PayPal::AccessTokenRequest.new(@environment, @refresh_token)
        tokenResponse = execute(accessTokenRequest)
        @access_token = PayPal::AccessToken.new(tokenResponse.result)
      end
      request.headers['Authorization'] = @access_token.authorizationString
    end

    def _add_headers(request)
      request.headers['Accept-Encoding'] = 'gzip'
      request.headers['sdk_name'] = 'Checkout SDK'
      request.headers['sdk_version'] = VERSION
      request.headers['sdk_tech_stack'] = "Ruby#{RUBY_VERSION}"
      request.headers['api_integration_type'] = 'PAYPALSDK'
    end

    def _is_auth_request(request)
      request.path == '/v1/oauth2/token' ||
        request.path == '/v1/identity/openidconnect/tokenservice'
    end

    def _has_auth_header(request)
      request.headers.key?('Authorization')
    end

  end
end
