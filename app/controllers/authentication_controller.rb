class AuthenticationController < ApplicationController
    
    def log_in
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            authorization_payload = {
                user_id: user.id
            }
            encoded_token = TokenAuthorizationService.encode_authorization_token_from_payload(authorization_payload)
            cookies.encrypted[:auth_token] = { value: encoded_token, httponly: true }

            render json: {}, status: 201
        else
            render json: {}, status: 401
        end
    end
end
