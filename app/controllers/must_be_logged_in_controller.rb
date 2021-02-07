class MustBeLoggedInController < ApplicationController
  
  def secret_stuff
    if current_user
      render :json => {super_secret_message: "Drink More Ovaltine #{current_user.email}"}
    else
      render :json => {boring_message: "Nice try random person"}
    end
  end
end
