Rails.application.routes.draw do
  namespace :api, defaults: { format:'json' } do
    namespace :v1 do
      resources :users, only: [:create]
      resources :objects, controller: "my_objects", except: [:new,:edit]
      
      match "*unmatched", via: [:options], to: "master_api#xhr_options_request"
    end

  end
end
