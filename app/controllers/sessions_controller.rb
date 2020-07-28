class SessionsController < ApplicationController
    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            render json: {user: user}
        else
            render json: {status: 401}
        end
    end
end
