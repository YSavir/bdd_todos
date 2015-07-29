require 'rails_helper'

RSpec.feature "ViewSingleTodo", type: :feature do

  feature 'Given an incomplete todo' do
    let! (:todo) { create(:todo) }
    
    feature 'and the user visits its show page' do
      before { visit todo_path(todo) }
      subject { page }

      # General page properties, not specific to incomplete todos
      it { is_expected.to have_content todo.title }
      it { is_expected.to have_link 'Edit', :href => edit_todo_path(todo) }

      feature 'and deletes the todo' do
        before { click_button 'Delete Todo' }

        specify { expect(current_path).to eq todos_path }        
        it { is_expected.to have_no_link 'Edit', :href => edit_todo_path(todo) }
      end
      
      # Page properties specifically for incomplete todos
      it { is_expected.to have_content 'Todo incomplete' }
      it { is_expected.to have_selector "input[type=submit][value='Complete Todo']" }

      feature 'and clicks to complete the todo' do
        before { click_button 'Complete Todo' }

        specify { expect(current_path).to eq todo_path(todo) }
        it { is_expected.to have_content 'Todo complete' }
      end

    end
  end

  feature 'Given a complete todo' do
    let! (:todo) { create(:complete_todo) }

    feature 'and the user visits its show page' do
      before { visit todo_path(todo) }
      subject { page }
      
      it { is_expected.to have_content "Todo complete" }
      it { is_expected.to have_no_content "Complete Todo" }
    end
  end

end

