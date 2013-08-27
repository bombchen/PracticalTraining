PracticalTraining::Application.routes.draw do

  get 'reports/instore'

  get 'reports/consume'

  get 'reports/lost'

  get 'reports/category'

  get 'reports/department'

  get 'reports/teacher'

  get 'reports/overall'

  get 'facility_alert/application'

  controller :admin do
    get 'index' => :index
  end

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :user_role_mappings do
    collection do
      delete 'index', :via => :get
    end
  end

  resource :uploads

  resources :users do
    collection do
      delete 'index', :via => :get
    end
    member do
      get 'reset_password'
    end
  end


  resources :field_statuses do
    collection do
      delete 'index', :via => :get
    end
  end


  resources :departments do
    collection do
      delete 'index', :via => :get
    end
  end


  resources :facility_categories do
    collection do
      delete 'index', :via => :get
    end
  end


  resources :plants


  resources :fields do
    collection do
      delete 'index', :via => :get
    end
  end


  resources :stocking_details do
    collection do
      delete 'index', :via => :get
    end
  end


  resources :stockings do
    member do
      put 'end_stocking'
      get 'stocking'
    end
  end


  resources :facility_ios do
    collection do
      delete 'index', :via => :get
    end
  end


  resources :facility_reasons do
    collection do
      delete 'index', :via => :get
    end
  end


  resources :facility_totals do
    collection do
      delete 'index', :via => :get
    end
  end


  resources :facility_properties do
    collection do
      delete 'index', :via => :get
    end
  end


  resources :scheduled_facilities do
    collection do
      delete 'index', :via => :get
    end
  end


  resources :scheduled_courses do
    collection do
      get 'get_available_fields'
      delete 'index', :via => :get
    end
  end


  resources :facility_returns do
    member do
      get 'borrow_process'
      get 'return_process'
    end
    collection do
      get 'outstanding'
    end
  end


  resources :record_reviews do
    collection do
      delete 'index', :via => :get
    end
  end


  resources :course_reviews do
    collection do
      delete 'index', :via => :get
    end
  end


  #scope '(:locale)' do

  resources :practice_records do
    collection do
      delete 'index', :via => :get
    end
  end


  resources :facility_applications do
    collection do
      delete 'index', :via => :get
    end
  end


  resources :courses do
    collection do
      get 'get_available_fields'
      delete 'index', :via => :get
    end
  end


  resources :facilities do
    collection do
      delete 'index', :via => :get
    end
  end

  resources :facility_report do
    collection do
      delete 'index', :via => :get
    end
  end

  resources :facility_alert do
    collection do
      delete 'index', :via => :get
    end
  end

  resources :facility_trace do
    collection do
      delete 'index', :via => :get
    end
  end

  #end

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
  root :to => 'admin#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
