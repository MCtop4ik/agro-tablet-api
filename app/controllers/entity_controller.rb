class EntityController < ApplicationController
  def get_farms
    result = {
      data: {},
      status: 500
    }
    if authenticate
      service_data = Caspio::Client.instance.get_hay_farms
      result[:data] = service_data[:data]
      result[:status] = service_data[:status]
    end
    render json: result[:data].to_json, status: result[:status]
  end

  def get_fields
    result = {
      data: {},
      status: 500
    }
    if authenticate
      service_data = Caspio::Client.instance.get_hay_fields
      result[:data] = service_data[:data]
      result[:status] = service_data[:status]
    end
    render json: result[:data].to_json, status: result[:status]
  end

  def get_hay_types
    result = {
      data: {},
      status: 500
    }
    if authenticate
      service_data = Caspio::Client.instance.get_hay_types
      result[:data] = service_data[:data]
      result[:status] = service_data[:status]
    end
    render json: result[:data].to_json, status: result[:status]
  end

  def get_hay_cuts
    result = {
      data: {},
      status: 500
    }
    if authenticate
      service_data = Caspio::Client.instance.get_hay_cuts
      result[:data] = service_data[:data]
      result[:status] = service_data[:status]
    end
    render json: result[:data].to_json, status: result[:status]
  end

  def get_time_hours
    result = {
      data: {},
      status: 500
    }
    if authenticate
      service_data = Caspio::Client.instance.get_time_hours
      result[:data] = service_data[:data]
      result[:status] = service_data[:status]
    end
    render json: result[:data].to_json, status: result[:status]
  end


  def get_time_minutes
    result = {
      data: {},
      status: 500
    }
    if authenticate
      service_data = Caspio::Client.instance.get_time_minutes
      result[:data] = service_data[:data]
      result[:status] = service_data[:status]
    end
    render json: result[:data].to_json, status: result[:status]
  end


  def authenticate
    auth_token = request.headers["Authorization"]
    Auth::AccessControl.new.is_authenticated(auth_token)
  end
end