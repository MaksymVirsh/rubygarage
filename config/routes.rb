Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      omniauth_callbacks: 'omniauth_callbacks'
    },
    path: 'auth',
    path_names: {
      sign_in:      'login',
      sign_out:     'logout',
      password:     'secret',
      confirmation: 'verification',
      unlock:       'unblock',
      sign_up:      'registration'
    }

  authenticated :user do
    root 'todo#index', as: :authenticated_root
  end

  root to: redirect('/auth/login')

  resources :projects, defaults: { format: :json }

  resources :tasks, defaults: { format: :json } do
    put :done, on: :member
    put :sort, on: :member
    put :deadline, on: :member
  end

  resources :comments, defaults: { format: :json }, only: [:create, :destroy]
end
