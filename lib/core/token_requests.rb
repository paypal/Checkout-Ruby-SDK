module PayPal
  class AccessTokenRequest
    attr_accessor :path, :body, :headers, :verb

    def initialize(environment, refreshToken = nil)
      @path = "/v1/oauth2/token"
      @body = {
        grant_type: "client_credentials"
      }

      if refreshToken
        @body[:grant_type] = "refresh_token"
        @body[:refresh_token] = refreshToken
      end

      @headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => environment.authorizationString
      }
      @verb = "POST"
    end
  end

  class RefreshTokenRequest
    attr_accessor :path, :body, :headers, :verb

    def initialize(environment, authorization_code)
      @path = "/v1/identity/openidconnect/tokenservice"
      @body = {
        grant_type: "authorization_code",
        code: authorization_code
      }
      @headers = {
        "Content-Type" => "application/x-www-form-urlencoded",
        "Authorization" => environment.authorizationString
      }
      @verb = "POST"
    end
  end
end
