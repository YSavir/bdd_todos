Rails.application.routes.draw do
  resources :todos, :only => [:index, :create, :show]
  
  patch '/todos/:id' => 'todos#toggle_completeness', :as => 'toggle_todo_completeness'
end
