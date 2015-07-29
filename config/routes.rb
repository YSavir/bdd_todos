Rails.application.routes.draw do
  resources :todos, :only => [:index, :create, :show, :edit, :update, :destroy]
  
  patch '/todos/:id/completeness' => 'todos#toggle_completeness', :as => 'toggle_todo_completeness'
end
