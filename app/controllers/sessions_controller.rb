class SessionsController < ApplicationController
    
    # Should set httponly cookie only, no token return
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            cookies.encrypted[:boomdsf] = {value:  'jason', httponly: true}
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

    # check httponly cookie, return jwt token if it's legit, 401 if not
    # add refresh token route
    def refresh_token
    end
end
