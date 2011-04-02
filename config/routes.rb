Lostspot::Application.routes.draw do

  resources :forums, :only => [:index, :show] do
    resources :topics, :except => [:destroy] do
    end
  end
  
  match "listings/:id/email_owner" => "listings#email_owner", :as => "email_owner", :via => :post
  match "listings/:id/close" => "listings#close", :as => "close_listing", :via => :post
  
  resources :posts, :except => [:destroy]

  resources :external_photos

  resources :listing_categories

  devise_for :users, :controllers => { :sessions => "user/sessions" }
  
  resources :listings do
    get :bubble
    get :poster
    collection do
      get :index
      get :search
      post :search
    end
  end

  root :to              => "home#index"
  
  match "profiles/:id"  => "profiles#show", :as => "profile"
  
  match "dashboard"     => "profiles#dashboard"
  
  match "community"     =>  "forums#index"
  
  match "community/article/:id"  => "forum#show", :as => "forum_article"
  
  match "help"          =>  "help#index"
  match "privacy"          =>  "help#privacy"
  match "terms"          =>  "help#terms"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
