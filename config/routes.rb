Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  post 'classroom', action: 'send', controller: 'classrooms'
end
