Rails.application.routes.draw do

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users
  
  get 'favorite_car', to: 'saved_cars#favorite_car', as: 'favorite_car'
  get 'car_details/:id/saved_car', to: 'saved_cars#save_car', as: 'saved_car'
  get 'about', to: 'homes#about', as: 'about'


  root to: 'homes#welcome'
  get 'dashboard', to: 'dashboards#dashboard', as:'dashboard'
  get 'profile', to: 'users#profile', as: 'profile'  # profile
  get 'home', to: 'homes#welcome', as:'home'
  #get 'car_details', to: 'cars#index', as: 'car_details' # car details
  get 'car_details/:id', to: 'cars#car_details', as:'car_details'

  get 'car_details/:id/edit', to: 'cars#edit', as: 'update_car'
  put 'car_details/:id', to: 'cars#update' # update (put)
  patch 'car_details/:id', to: 'cars#update' # update (patch)

  # Navid
  # get 'users/:id/edit_password', to: 'users#edit_password', as: 'change_password' # edit
  # patch 'users/:id', to: 'users#update_password' # update (as needed)
  # put 'users/:id', to: 'users#update_password' # update (full replacement)

  # Hosneara: added routes for delete car # 
  get 'car_details/:id/confirm_delete', to: 'cars#delete_car', as: 'delete_car'
  delete 'car_details/:id/confirm_delete', to: 'cars#destroy'
  #get 'car_details/:id/delete_car_image', to: 'cars#delete_car_image', as: 'delete_car_image'
  
  get 'send_message_to_seller/:id', to: 'conversations#send_message_to_seller', as:'send_message_to_seller'
  get 'send_message', to: 'conversations#index', as: 'send_message'
  get 'notification/:id', to: 'notifications#show', as: 'notification'

  get 'new_conversation/:id', to: 'conversations#new_conversation', as: 'new_conversation'

  post 'new_message', to: 'messages#new_message', as: 'new_message'

  get 'report', to: 'users#report', as: 'report'
  post 'report', to: 'users#report_authority', as: 'report_authority'
  get 'view_report', to: 'users#index', as: 'view_report'
  get 'authority_view', to: 'users#authority_view', as: 'authority_view'

  get 'search', to: 'homes#search', as:'search'
  get 'advance_search', to: 'homes#advance_search', as:'advance_search'
  
  get 'upload_car', to: 'cars#upload_car', as: 'upload_car'
  post 'upload_car', to: 'cars#upload_car_form', as: 'upload_car_form'

  post 'rate_this_seller', to: 'cars#rate_this_seller', as: 'rate_this_seller'
  post 'mark_as_sold', to: 'cars#mark_as_sold', as:'mark_as_sold'

end
