Rails.application.routes.draw do
  resources :todos, :only => [:index, :create, :show]
end
