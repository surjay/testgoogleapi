Rails.application.routes.draw do
  root to: 'dashboard#index'

  resources :dashboard, only: :index do
    collection do
      post :drive_time
    end
  end
end
