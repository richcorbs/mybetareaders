Mybetareaders::Application.routes.draw do

  resources :pages

  resources :coupons

  resources :charges

  resources :audiences
  resources :criteria
  resources :genres
  resources :markets
  resources :prices
  resources :volunteers

  get '/' => "pages#home"

  get 'documents/:id/feedback' => 'documents#feedback', :as => :feedback
  get 'documents/:id/pay_for_document' => "documents#pay_for_document", :as => :pay_for_document
  get 'documents/:id/readers' => 'documents#readers', :as => :document_readers
  get 'documents/:id/volunteers' => 'documents#volunteers', :as => :document_volunteers
  get "login" => "sessions#new"
  get "logout" => "sessions#destroy"
  get 'my_reading' => 'documents#reading', :as => :reading
  get 'my_writing' => 'documents#writing', :as => :writing
  get 'preferences' => "users#preferences"
  get 'signup' => "users#new"
  get 'browse' => 'documents#browse', :as => :user_home

  get '/' => 'pages#home'
  get 'features' => 'pages#features'
  get 'the_plans' => 'pages#plans'

  delete 'documents/:id/feedback' => 'documents#feedback'

  post '/change_password' => 'users#change_password', :as => :change_password
  post 'documents/create_feedback' => 'documents#create_feedback'
  post 'documents/feedback_complete' => 'documents#feedback_complete'
  post 'documents/feedback_rating' => 'documents#feedback_rating'
  post 'documents/:id/invite_volunteer' => 'documents#invite_volunteer', :as => :document_invite_volunteer
  post 'documents/:id/uninvite_volunteer' => 'documents#uninvite_volunteer', :as => :document_uninvite_volunteer
  post 'documents/:id/pay_for_document' => "documents#pay_for_document"
  post 'documents/volunteer_now' => 'documents#volunteer_now'
  post 'documents/writer_flag_paragraph' => 'documents#writer_flag_paragraph'
  post 'feedbacks/:id/decline_invitation' => 'feedbacks#decline_invitation', :as => :decline_invitation
  post 'paragraph_ratings/create_or_update' => 'paragraph_ratings#create_or_update'
  post 'paragraph_ratings/set_bookmark' => 'paragraph_ratings#set_bookmark'

  put 'users/:id/preferences_update' => 'users#preferences_update'

  resources :doctypes
  resources :documents
  resources :feedbacks
  resources :paragraphs
  resources :paragraph_comments
  resources :paragraph_ratings
  resources :sessions
  resources :users

  root :to => 'pages#home'

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
  # match ':controller(/:action(/:id))(.:format)'
end
