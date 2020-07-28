class SessionsController < ApplicationController
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            authorization_payload = {
                user_id: user.id
            }
            render json: {
                user: user, 
                jwt: TokenAuthorizationService.encode_token_from_payload(authorization_payload)
            }
        else
            render json: {status: 401}
        end
    end
end
