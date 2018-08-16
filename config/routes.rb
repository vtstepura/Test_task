Rails.application.routes.draw do
  root 'welcome#index'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  namespace :admin do
    resources :users
  end
  get 'signup', to: 'users#new'

end
