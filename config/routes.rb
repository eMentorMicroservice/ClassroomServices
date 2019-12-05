Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  
  namespace :classrooms do
    post 'send'
    get 'test'
  end
  
  resources :rooms, only: [:create]
  namespace :rooms do
    get 'find'
    post 'send_info'
    post 'send_message'
    get 'test'
  end
end
