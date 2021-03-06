Fuzion::Application.routes.draw do
  devise_for :users

  namespace :admin do

    resources :users 
    resources :teams
    resources :competitions
    resources :matches do
      member do
        get :scoresheet
        put :update_scoresheet
      end
      collection do
        get :select_teams
      end
    end
    resources :posts do
      member do
        get 'toggle_highlighted'
      end
    end

    root :to => "dashboard#index"
  end

  resources :matches do
    member do
      get :set_participation
      put :update_participation
      get :update_participation_from_mail
      get :set_notation
      put :update_notation
    end
  end

  resources :classement, :as => :teams, :controller => :teams do
    collection do
      match "annee/:year", :to => "teams#show_past_year", :as => :show_past_year
      get :get_another_year
    end
  end
  resources :comments
  
  resources :users do
    collection do
      match "annee/:year", :to => "users#show_past_year", :as => :show_past_year
      get :get_another_year
    end
  end

  match "palmares", :to => "statics#palmares"
  match "login_content", :to => "home#login_content"
  root :to => "home#index"
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
