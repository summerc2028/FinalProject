FinalProject::Application.routes.draw do

  # Users
  resources :users, except: [:show, :update]
  match "/users/:username", to: "users#show", via: "get", as: "usernames"
  match "/users/:username/update", to: "users#update", via: "post", as: "update_usernames"
  match "/signup", to: "users#new", via: "get"
  match "/users/:username/calendar", to: "users#calendar", via: "get", as: "calendar"
  match "/users/:username/status", to: "users#update_status", via: "post", as: "update_status"
  match "/users/:username/day-view", to: "users#show_day", via: "get", as: "show_day"

  # Sessions
  resources :sessions, only: [:create]
  match "/signin", to: "sessions#new", via: "get"
  match "/signout", to: "sessions#destroy", via: "delete"

  # Static
  root "static_pages#home"
  match "/help", to: "static_pages#help", via: "get"

  #Foods
  resources :foods, only: [:new, :create, :show, :index, :destroy]
  match "/users/:username/enter_food", to: "foods#new", via: "get"
  match "/users/:username/remove_food", to: "foods#destroy", via: "delete"
  match "/users/:username/update_food", to: "foods#update", via: "get"

  #Activities
  resources :activities, only: [:index]
  match "/users/:username/enter_activity", to: "activities#new", via: "get", as: "new_activity"
  match "/users/:username/create_activity", to: "activities#create", via: "post", as: "create_activity"
  match "/users/:username/single-view/:id", to: "activities#show", via: "get", as: "show_activity"
  match "/users/:username/remove_activity", to: "activities#destroy", via: "delete"
  match "/users/:username/activities/:id/update", to: "activities#update", via: "post", as: "update_activity"


  #Exercises
  resources :exercises, only: [:new, :create, :show, :index, :destroy]
  match "/users/:username/enter_exercise", to: "exercises#new", via: "get"
  match "/users/:username/remove_exercise", to: "exercises#destroy", via: "delete"
  match "/users/:username/update_exercise", to: "exercises#update", via: "get"


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
