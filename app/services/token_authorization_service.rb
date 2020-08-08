class TokenAuthorizationService
    require 'jwt'

    JWT_SECRET = 'othersecresdf'

    def self.encode_token_from_payload(payload)
        expiration_time = (Time.now + 1.minutes).to_i
        payload[:exp] = expiration_time
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

    def self.encode_refresh_token_from_payload(payload)
        expiration_time = (Time.now + 10.minutes).to_i
        payload[:exp] = expiration_time
        JWT.encode(payload, JWT_SECRET)
    end
end
