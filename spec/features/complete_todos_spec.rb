require 'rails_helper'

RSpec.feature "CompleteTodos", type: :feature do
  feature 'On a todo\'s page' do
    feature 'for an incomplete todo' do
      let! (:todo) { create(:todo) }

      scenario 'there should be a button to complete the todo' do
        visit todo_path(todo)        
        
        expect(page).to have_selector("input[type=submit][value='Complete Todo']")
      end

      scenario 'the user should be able to mark todo as complete' do
        visit todo_path(todo)
        click_button 'Complete Todo'

        expect(current_path).to eq(todo_path(todo))
        expect(page).to have_content("Todo Complete")
      end
    end

    feature 'for a complete todo' do
      let! (:todo) { create(:complete_todo) }
      scenario 'the user should not see a button to mark the todo as complete' do
        visit todo_path(todo)

        expect(page).to have_no_content("Complete Todo")
      end
    end
  end
end
