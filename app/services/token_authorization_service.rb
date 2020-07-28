class TokenAuthorizationService
    require 'jwt'

    def self.encode_token_from_payload(payload)
        JWT.encode(payload, 'secret')
    end

    def self.decode_token_from_header(header)
        
    end
end
