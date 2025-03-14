Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  post "v1/authentification/login", to: "authentification#login"
  put "v1/authentification/change_profile_info", to: "authentification#change_info"
  put "v1/change_password", to: "authentification#change_password"

  post "v1/synchronisation", to: "synchronisation#synchronisation"

  get "v1/farms", to: "entity#get_farms"
  get "v1/fields", to: "entity#get_fields"
  get "v1/hay-types", to: "entity#get_hay_types"
  get "v1/hay-cuts", to: "entity#get_hay_cuts"
  get "v1/time-hours", to: "entity#get_time_hours"
  get "v1/time-minutes", to: "entity#get_time_minutes"
  resources :hay_production_transactions, only: [:index]

end
