Rails.application.routes.draw do

  resources :leafs

  post 'clicks' => 'clicks#create', :as => 'clicks'
  post 'user_favs' => 'user_favs#create', :as => 'user_favs'
  delete 'user_favs' => 'user_favs#destroy', :as => 'delete_user_favs'

  get 'pages/:id' => 'high_voltage/pages#show',  :as => 'pages'

  get "/tagged/:id" => "leafs#tag", :as => :tagged_posts
  get "featured" => "leafs#featured", :as => :featured

  get 'upload', to: "leafs#new", as: "upload"
  get 'leafs/new/audio', to: "leafs#audio", as: "new_audio"
  get 'leafs/new/video', to: "leafs#video", as: "new_video"
  get 'leafs/new/photo', to: "leafs#photo", as: "new_photo"
  get 'leafs/new/text', to: "leafs#text", as: "new_text"

  devise_for :users,  :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  resources :users

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
