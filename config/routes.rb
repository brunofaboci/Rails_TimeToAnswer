Rails.application.routes.draw do
  namespace :site do
    get 'welcome/index' # enviado pela url
    get 'search', to: 'search#questions' # enviado pela url
    get 'subject/:subject_id/:subject', to: 'search#subject', as: 'subject' # enviado pela url
    post 'answer', to: 'answer#question' # não é enviado pela url
  end
  namespace :users_backoffice do
    get 'welcome/index'
    get 'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
  end
  namespace :admins_backoffice do
    get 'welcome/index'   #Dashboard
    resources :admins     #Admins
    resources :subjects   #Subjects
    resources :questions  #Questions
  end
  devise_for :admins, skipe: [:registration] # exclui a rota para admins_backoffice/sig_up
  devise_for :users

  get 'backoffice', to: 'admins_backoffice/welcome#index'
  
  root to: 'site/welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
