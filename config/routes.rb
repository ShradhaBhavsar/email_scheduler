Rails.application.routes.draw do
  devise_scope :user do 
    root 'devise/sessions#new'
  end
  devise_for :users
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
