class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    
    if user
      user.reset_session_token!
      redirect_to cats_url
    else
      flash.now[:errors] = ['Invalid credentials']
      render :new
    end
  end
  
  def destroy
    if current_user 
      current_user.reset_session_token!
      session[:session_token] = nil
    end
  end
end