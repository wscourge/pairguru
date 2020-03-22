Rails.application.routes.draw do
  devise_for :users

  root "home#welcome"
  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end
  resources :comments, only: [:create], defaults: { format: :js }
  delete "/comments", to: "comments#destroy", action: :destroy, defaults: { format: :js }
end
