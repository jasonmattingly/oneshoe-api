class SessionsController < ApplicationController
    
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: {}, status: 201
    else
      render json: {}, status: 401
    end
  end

  def destroy
    reset_session
    @current_user = nil
    render json: {}, status: 200
  end
end
