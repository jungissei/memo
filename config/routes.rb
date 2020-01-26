Rails.application.routes.draw do
  resources :learns, :only => [:index, :show, :update] do
    collection do
      get 'complete'
    end
  end

  resources :posts
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  root to: 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
