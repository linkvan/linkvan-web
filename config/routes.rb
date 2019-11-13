Linkvan::Application.routes.draw do
#api routes
namespace :api do
  defaults format: :json do
    resources :facilities, only: [:index, :create, :update]
    get :run, to: 'facilities#generate_facilities'
    resources :users, only: [:index, :create, :update] do
      member do
        post :toggle_verified, to: 'users#toggle_verified'
      end #/member
    end #/users
    post :login, to: 'sessions#create'
    get :login, to: 'sessions#create'
    delete :logout, to: 'sessions#destroy'
    resources :zones, only: [:index] do
      member do
        get :admin, to: 'zones#list_admin'
        post :admin, to: 'zones#add_admin'
        delete :admin, to: 'zones#remove_admin'
      end #/member
    end #/zones
  end #defaults
end #/api

  # get 'api/facilities', to: 'api#all' #only enable if needed
  # get 'api/facilities/filter/:scope', to: 'api#filtered'
  # get 'api/facilities/filteredtest', to: 'api#filteredtest'
  # get 'api/facilities/search', to: 'api#search'
  # get 'api/facilities/:id', to: 'api#show'
  # get 'api/getchanges', to: "api#getchanges"

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
  get 'users/:id/toggle_verify' => "users#toggle_verify"
  get 'facilities/:id/toggle_verify' => "facilities#toggle_verify", as: 'toggle_facilities'
  get 'alerts' => 'alerts#index'
  get 'alerts/:id/active' => 'alerts#active'
  get 'alerts/:id/deactive' => 'alerts#deactive'
  get 'users/:id/analytics' => 'analytics#show', as: 'analytics'
  get 'notices' => 'notices#index'
  get 'notices/list' => 'notices#list'
  get 'notice/:slug' => 'notices#view'
  resources :alerts
  resources :notices
  resources :facilities

  # match "users/:id/toggle_verify" => "users#toggle_verify"


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
