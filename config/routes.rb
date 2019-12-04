Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  post 'classroom', action: 'send', controller: 'classrooms'
  
  namespace :rooms do
    get 'find_room'
    post 'send_info'
    post 'send_message'
  end
end
