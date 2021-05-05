# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  as :users do
    # get 'users/sign_in', :to => 'devise/sessions#new', :as => :registration
  end
  root 'events#index'
  get 'users/pending'
  get 'help/contact'
  get 'help/user_manual'

  resources :committees
  resources :attendance_committee
  resources :attendance_user

  resources :events do
    member do
      get :delete
    end
    collection do
      get :index_day
    end
  end

  resources :rsvps do
    member do
      get :delete
    end
  end

  resources :users do
    member do
      get :soft_delete
    end
  end

  resources :attendance_logs do
    member do
      get :delete
    end
  end
end
