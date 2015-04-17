require 'rails_helper'

RSpec.feature "AddNewTodos", type: :feature do
  feature 'When a user visits the todos page' do
    let (:todo) {Todo.last}
    scenario 'they should be able to submit a new todo' do
      visit todos_path
      fill_in 'todo_title', :with => 'Test Todo'
      click_button 'Add Todo'
      todo = Todo.last
      
      expect(current_path).to eq(todo_path(todo))
      expect(page).to have_content(todo.title)
    end
  end
end
