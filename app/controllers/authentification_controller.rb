class AuthentificationController < ApplicationController

  def hash_password(password)
    Digest::MD5.hexdigest(password)
  end
  def login
    response = Auth::AuthHelper.new.auth(params[:email], params[:password])
    render json: response[:json], status: response[:status]
  end

  def change_info
    auth_token = request.headers["Authorization"]
    if Auth::AccessControl.new.is_authenticated(auth_token)
      response = Auth::ProfileHelper.new.change_public_info(params[:profile_info])
      data = response[:json]
      status = response[:status]
    else
      data = 'Unauthorised'
      status = 401
    end
    render json: data.to_json, status: status
  end

  def change_password
    user_id = params[:user_id]
    new_password = params[:new_password]
    insert_data = {
      'Password': hash_password(new_password)
    }
    p insert_data
    Caspio::Client.instance.update_users_info(insert_data, user_id)
    render json: 'Success'
  end
end

