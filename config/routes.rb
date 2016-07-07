Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  root 'static_pages#home'

  resources :games, only: [:new, :create, :show, :update]
  resources :boards, only: [:show, :update]
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

end
