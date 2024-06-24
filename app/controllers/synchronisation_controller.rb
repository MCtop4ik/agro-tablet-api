class SynchronisationController < ApplicationController
  def synchronisation
    auth_token = request.headers["Authorization"]
    if Auth::AccessControl.new.is_authenticated(auth_token) || true
      params.permit!
      insert_data = params[:synchronisation_data]
      user_data = params[:user_data]
      SynchronisationQueueJob.perform_later(insert_data, user_data)
      data = 'synchronisation succeeded'
      status = 200
    else
      data = 'Unauthorised'
      status = 401
    end
    render json: data.to_json, status: status
  end
end

