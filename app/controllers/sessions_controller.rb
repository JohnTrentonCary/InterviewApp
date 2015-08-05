class SessionsController < ApplicationController
   def create
    auth = request.env["omniauth.auth"]
    user = if User.find_by_provider_and_uid(auth["provider"], auth["uid"])
             if current_user.access_token != auth["credentials"]["token"]
                current_user.update_access_token(auth)
             else
               User.find_by_provider_and_uid(auth["provider"], auth["uid"])
             end
           else
            User.create_with_omniauth(auth)
           end
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end
 
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
 
end
