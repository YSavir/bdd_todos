require 'rails_helper'

RSpec.feature "EditTodos", type: :feature do

  feature 'When visiting a todo\'s edit page,' do
    let! (:todo) { create(:todo) }
    subject { page }
    before { visit edit_todo_path(todo) }

    it { should have_content todo.title }
    it { should have_content '...editting...' }
    it { should have_field 'todo[title]', :with => todo.title }

    feature 'and the update form is submitted' do
      before do 
        fill_in 'todo[title]', :with => 'New Title'
        click_button 'Update Todo'
      end

      specify { expect(current_path).to eq todo_path(todo) }
      it { should have_content 'New Title' }
    end
  end
  
end
