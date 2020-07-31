module PayPal
  class AccessToken
    attr_accessor :access_token, :token_type, :expires_in, :date_created

    def initialize(options)
      @access_token = options.access_token
      @token_type = options.token_type
      @expires_in = options.expires_in
      @date_created = Time.now
    end

    def isExpired
      Time.now > @date_created + @expires_in
    end

    def authorizationString
      "#{@token_type} #{@access_token}"
    end
  end
end
