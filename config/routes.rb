Rails.application.routes.draw do

  resources :projects

  resources :categories
  resources :user_categories

  resources :leafs
  # resources :facebook_page

  post '/facebook_page' => 'facebook_page#create', :as => 'facebook_page'
  
  scope "/facebook/:id" do
    get '', to: 'facebook#show', :as => 'facebook_url'
  end

  post '/facebook' => 'profiles#facebook', :as => 'facebook'
  get '/facebook' => 'profiles#facebook', :as => 'facebook_get'
  get '/dashboard' => 'profiles#dashboard', :as => 'dashboard'
  post '/message' => 'profiles#message', :as => 'message'
  post '/comment' => 'leafs#comment', :as => 'comment'

  get 'apps' => 'profiles#apps', :as => 'apps'
  get 'admin' => 'leafs#admin', :as => 'admin'

  get 'tedx' => 'projects#tedx', :as => 'tedx'
  post 'search' => 'leafs#search', :as => 'search'
  post 'clicks' => 'clicks#create', :as => 'clicks'
  post 'user_favs' => 'user_favs#create', :as => 'user_favs'
  delete 'user_favs' => 'user_favs#destroy', :as => 'delete_user_favs'

  get 'pages/:id' => 'high_voltage/pages#show',  :as => 'pages'

  get "/media/:type" => "leafs#media", :as => :media
  get "/tagged/:id" => "leafs#tag", :as => :tagged_posts
  get "featured" => "leafs#featured", :as => :featured

  get 'upload', to: "leafs#new", as: "upload"
  get 'leafs/new/audio', to: "leafs#audio", as: "new_audio"
  get 'leafs/new/video', to: "leafs#video", as: "new_video"
  get 'leafs/new/photo', to: "leafs#photo", as: "new_photo"
  get 'leafs/new/text', to: "leafs#text", as: "new_text"

  devise_for :users,  :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  resources :users
  resources :profiles do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]

  

  # resources :photos

  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy'
  end

  resources :profiles, shallow: true do
    resources :leafs, :only =>[:show]
  end

  scope ":id" do
    get '', to: 'profiles#show', :as => 'vanity_url'
  end

  post '/facebook/:id/:leaf_id' => 'leafs#show', :as => 'leaf_url'

  scope ":user_id/:id" do
      get '', to: 'leafs#show', :as => 'vanity_leaf_url'
  end


  authenticated :user do
      root to: "leafs#index", as: :authenticated_root
    end

  unauthenticated do
    root to: "visitors#index"
  end
end
