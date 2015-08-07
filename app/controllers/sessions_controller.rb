class SessionsController < ApplicationController
   def create
    auth = request.env["omniauth.auth"]
          #1: Check if user is in database
    user = if User.find_by_provider_and_uid(auth["provider"], auth["uid"])
            #2: Check if current_user is set
            if current_user
              #3: Check if access tokens match 
              if current_user.access_token == auth["credentials"]["token"]
                User.find_by_provider_and_uid(auth["provider"], auth["uid"])
              #3: else update them
              else
               current_user.update_access_token     
              end
            #2: else set it
            else
              User.find_by_provider_and_uid(auth["provider"], auth["uid"])
            end
           #1: else create new user
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
