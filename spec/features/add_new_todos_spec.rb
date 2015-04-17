require 'rails_helper'

RSpec.feature "AddNewTodos", type: :feature do
  feature 'When a user visits the todos page' do
    scenario 'they should be able to submit a new todo' do
      visit todos_path
      fill_in 'todo_title', :with => 'Test Todo'
      click_button 'Add Todo'

      expect(response).to be_success
    end
  end
end
