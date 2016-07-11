Rails.application.routes.draw do
  # get 'rooms/show'

  root 'rooms#show'

  mount ActionCable.server => '/cable'

  # root 'static_pages#home'

  resources :games, only: [:new, :create, :show, :update]
  resources :boards, only: [:show, :update]
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

end
