FinalProject::Application.routes.draw do

  # Users
  resources :users, except: [:show, :update, :destroy]
  match "/users/:username", to: "users#show", via: "get", as: "usernames"
  match "/users/:username/update", to: "users#update", via: "post", as: "update_usernames"
  match "/signup", to: "users#new", via: "get"
  match "/users/:username/calendar", to: "users#calendar", via: "get", as: "calendar"
  match "/users/:username/status", to: "users#update_status", via: "post", as: "update_status"
  match "/users/:username/day-view", to: "users#show_day", via: "get", as: "show_day"
  match "/users/:username/exercise_food", to: "users#exercise_food", via: "get", as: "exercise_food"
  match "/users/:username/settings", to: "users#settings", via: "get", as: "settings"
  match "/users/:username/destroy", to: "users#destroy", via: "delete", as: "destroy_usernames"

  # Sessions
  resources :sessions, only: [:create]
  match "/signin", to: "sessions#new", via: "get"
  match "/signout", to: "sessions#destroy", via: "delete"

  # Static
  root "static_pages#home"
  match "/help", to: "static_pages#help", via: "get"

  #Foods
  resources :foods, only: [:index]
  match "/users/:username/enter_food", to: "foods#new", via: "get", as: "enter_food"
  match "/users/:username/remove_food", to: "foods#destroy", via: "get", as: "delete_food"
  match "/users/:username/foods/:id/update_food", to: "foods#update", via: "post", as: "update_food"
  match "/users/:username/create_food", to: "foods#create", via: "post", as: "create_food"
  match "/users/:username/food_item/:id", to: "foods#show", via: "get", as: "show_food"

  #Activities
  resources :activities, only: [:index]
  match "/users/:username/enter_activity", to: "activities#new", via: "get", as: "new_activity"
  match "/users/:username/create_activity", to: "activities#create", via: "post", as: "create_activity"
  match "/users/:username/single-view/:id", to: "activities#show", via: "get", as: "show_activity"
  match "/users/:username/remove_activity/:id", to: "activities#destroy", via: "get", as: "delete_activity"
  match "/users/:username/activities/:id/update", to: "activities#update", via: "post", as: "update_activity"


  #Exercises
  resources :exercises, only: [:create, :show, :index]
  match "/users/:username/enter_exercise", to: "exercises#new", via: "get", as: "enter_exercise"
  match "/users/:username/remove_exercise", to: "exercises#destroy", via: "get", as: "delete_exercise"
  match "/users/:username/update_exercise", to: "exercises#update", via: "post", as: "update_exercise"
 match "/users/:username/create_exercise", to: "foods#create", via: "post", as: "create_exercise"
  match "/users/:username/exercise_item/:id", to: "foods#show", via: "get", as: "show_exercise"

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
