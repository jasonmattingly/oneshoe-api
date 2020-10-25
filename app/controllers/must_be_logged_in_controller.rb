class MustBeLoggedInController < ApplicationController

    def secret_stuff
        if logged_in_user
            render :json => {super_secret_message: "Drink More Ovaltine #{logged_in_user.email}"}
        else
            render :json => {boring_message: "Nice try random person"}
        end
    end

    private
    
    def logged_in_user
        encoded_token = cookies.encrypted[:auth_token]
        decoded_payload = TokenAuthorizationService.decode_payload_from_encoded_token(encoded_token)
        return nil if decoded_payload.empty?
        
        user_id = decoded_payload[0]['user_id']
        return User.find(user_id)
    end
end
