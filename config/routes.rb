Linkvan::Application.routes.draw do
  #api routes

  get 'api/facilities', to: 'api#all' #only enable if needed
  get 'api/facilities/filter/:scope', to: 'api#filtered'
  get 'api/facilities/filteredtest', to: 'api#filteredtest'
  get 'api/facilities/search', to: 'api#search'
  get 'api/facilities/:id', to: 'api#show'
  get 'api/getchanges', to: "api#getchanges"

  get "contact_form/new"
  get "contact_form/create"
  resource :session
  resources :users

  get 'facilities/options', to: 'facilities#options'
  get 'facilities/directions/:id', to: 'facilities#directions'
  get "facilities/filter/:scope" => "facilities#filtered", as: :filtered_facilities
  get 'facilities/filter/:scope/:latitude&:longitude', to: 'facilities#filtered', as: :coords_facilities
  get 'facilities/filter/:scope/:latitude&:longitude&:sortby&:hours&:services&:suitable&:welcome', to: 'facilities#filtered', as: :searched_facilities
  get 'facilities/search', to: 'facilities#search', as: :search_bar_facilities
  get 'crisis', to: 'crisis#index'
  get 'disclaimer', to: 'disclaimer#index'
  get 'about', to: 'about#index'
  get 'images', to: 'images#index'
  root 'facilities#index'
  get 'signup' => 'users#new'
  get "signin" => "sessions#new"
  get 'contact', to: 'messages#new', as: 'contact'
  post 'contact', to: 'messages#create'



  resources :facilities


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
