class SessionsController < ApplicationController
    
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            authorization_payload = {
                user_id: user.id
            }

            cookies.encrypted[:refresh_token] = TokenAuthorizationService.encode_refresh_token_from_payload(authorization_payload)

            render json: { status: 201 }
        else
            render json: { status: 401 }
        end
    end

    def refresh_token
        encoded_token = cookies.decrypted[:refresh_token]
        decoded_payload = TokenAuthorizationService.decode_payload_from_encoded_token(encoded_token)

        if decoded_payload
            authorization_payload = {
                user_id: decoded_payload[0]['user_id']
            }

            render json: {
                status: 200,
                authorizationToken: TokenAuthorizationService.encode_authorization_token_from_payload(authorization_payload)
            }
        else
            render json: { status: 401 }
        end
    end
end
