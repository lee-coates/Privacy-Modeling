Rails.application.routes.draw do
  devise_for :users
  root to: 'generate_dashboard#select_categories'

  resource :dashboard, only: :show
  resources :generate_dashboard

  namespace :admin do
    get '/', to: 'rules#index'
    resources :personal_information_items, only: %w(index new edit update destroy create)
    resources :use_items, only: %w(index new edit update destroy create), path: 'uses'
    resources :categories, only: %w(index new edit update destroy create)
    resources :rules, only: [:index, :update] do
      collection do
        get :generate
        post :import
      end
      resources :context_items, only: [:create, :destroy]
    end
  end

end
