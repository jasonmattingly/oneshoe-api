class TokenAuthorizationService
    require 'jwt'

    JWT_SECRET = 'othersecresdf'
    REFRESH_TOKEN_EXPIRATION_TIME = (Time.now + 2.days).to_i
    AUTHORIZATION_TOKEN_EXPIRATION_TIME = (Time.now + 1.minutes).to_i

    def self.encode_authorization_token_from_payload(payload)
        payload[:exp] = AUTHORIZATION_TOKEN_EXPIRATION_TIME
        JWT.encode(payload, JWT_SECRET)
    end

    def self.encode_refresh_token_from_payload(payload)
        payload[:exp] = REFRESH_TOKEN_EXPIRATION_TIME
        payload[:httponly] = true
        JWT.encode(payload, JWT_SECRET)
    end

    def self.decode_payload_from_encoded_token(encoded_token)
        return [] unless encoded_token

        # Removing the leading 'Bearer' text from token
        encoded_token = encoded_token.split(' ').last 

        begin
            JWT.decode(encoded_token, JWT_SECRET, true, algorithm: 'HS256')
        rescue JWT::DecodeError
            []
        end
    end
end
