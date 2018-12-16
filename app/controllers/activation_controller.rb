class ActivationController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if !user.activated? && user.activation_digest == params[:id]
      user.activate
      flash[:success] = 'Account activated!'
      redirect_to root_path
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_path
    end
  end
end
