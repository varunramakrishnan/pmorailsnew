Rails.application.routes.draw do
  resources :time_tracks
  resources :projects
  get 'account_resource_mappings/index'

  get 'account_resource_mappings/show'

  get 'account_resource_mappings/new'

  get 'account_resource_mappings/edit'

  get 'account_resource_mappings/create'

  get 'account_resource_mappings/update'

  get 'account_resource_mappings/destroy'

  resources :users
  resources :roles
  resources :skills
  resources :resources
  resources :services
  resources :organisational_units
  resources :accounts

  post 'user/search' => 'users#search'
  get 'managers' => 'resources#findmanagers'
  get 'service_units/:id' => 'organisational_units#services'
  get 'filtered-resources/:id' => 'resources#filtered'
  post 'resource-occupied' => 'resources#occupied'
  post 'resource-new-occupied' => 'resources#newoccupied'
  get 'account-resources/:id' => 'account_resource_mappings#accountresources'
  get 'mapped-resources/:id' => 'account_resource_mappings#mappedresources'
  get 'model-resources/:id' => 'account_resource_mappings#modelresources'
  post 'account-details' => 'resources#accountdetails'
  post 'delete-account-mapping' => 'account_resource_mappings#delete_account_mapping'
  post 'resources-dates' => 'resources#resourcedates'
  post 'skill-dates' => 'resources#skilldates'
  post 'new-dates' => 'resources#newdates'
  post 'freeresources' => 'resources#freeresources'
  post 'get-service-dates' => 'accounts#servicedates' # get service start date and end date from db
  get 'allfiltered-resources/:id' => 'resources#allfiltered'
  post 'disenresourcedates' => 'resources#disenresourcedates'
  get 'accounts-services/:id' => 'accounts#account_services' 
  get 'accounts-projects/:id/:sid' => 'accounts#account_projects' 
  post 'deletedependency' => 'application#deletedependency' 
  post 'filtered-projects' => 'projects#filteredprojects' 
  post 'check-availablity' => 'account_resource_mappings#check_availablity'
  post 'save-timecard' => 'time_tracks#save_timecard'
  post 'get-timecard' => 'time_tracks#get_timecard'
  get 'resource-projects/:id' => 'account_resource_mappings#resource_projects'
  post 'get-resource-pie-data' => 'time_tracks#get_resource_pie_data'

  
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
