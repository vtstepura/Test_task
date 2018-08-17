Rails.application.routes.draw do
  root 'welcome#index'

  get 'signup', to: 'users#new'

  get 'users', to: 'users#new'

  resources :users, only: %i[new create]

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  namespace :admin do
    resources :users, except: %i[mew create]
  end
end
