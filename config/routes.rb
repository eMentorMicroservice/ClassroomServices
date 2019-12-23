Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  
  resources :rooms, only: [:create]
  namespace :rooms do
    get 'find'
    get 'get_info'
    post 'send_info'
    post 'send_message'
    post 'extend_class'
    post 'send_draw'
  end
end
