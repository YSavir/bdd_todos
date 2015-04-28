require 'rails_helper'

RSpec.feature "ViewAllTodos", type: :feature do
  context 'When viewing the index page' do
    let (:todo_els) { page.all('.todo') }
    let (:complete_todo_els) { page.all('.todo.complete') }
    let (:incomplete_todo_els) {page.all('.todo.incomplete') }
    subject { todo_els }
    
    context 'and there are three todos' do
      let! (:todos) { create_list(:todo, 3) }
      before { visit todos_path }

      scenario { should have_exactly(3).items }
      # Test will be vialbe once Capyabara accepts my pull request to allow
      # for regexp href values
      # scenario { should all(have_link('Edit', :href => /\/todos\/\d+\/edit/)) } 
    end

    context 'and there are four todos' do
      let! (:todos) { create_list(:todo, 4) }
      before { visit todos_path }

     scenario { should have_exactly(4).items }
    end

    context 'and there are four complete todos and three incomplete todos' do
      let! (:complete_todos) { create_list(:complete_todo, 4) }
      let! (:incomplete_todos) { create_list(:todo, 3) }
      before { visit todos_path }
      
     scenario { should have_exactly(7).todos }
     scenario { should contain(4).complete_todos }
     scenario { should contain(3).incomplete_todos }

      context 'and I click to complete an incomplete todo' do
        before { page.first('.complete-button').click }
        specify { expect(page.current_path).to eq(todos_path) }
       scenario { should contain(5).complete_todos }
       scenario { should contain(2).incomplete_todos }
      end

      context 'and I click to uncomplete a complete todo' do
        before { page.first('.uncomplete-button').click }
        specify { expect(page.current_path).to eq(todos_path) }
       scenario { should contain(3).complete_todos }
       scenario { should contain(4).incomplete_todos }
      end
    end
  
  end
end

