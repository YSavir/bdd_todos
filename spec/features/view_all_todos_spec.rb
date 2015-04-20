require 'rails_helper'

RSpec.feature "ViewAllTodos", type: :feature do
  feature 'When viewing the index page' do
    feature 'The user should be able to see all the todos.' do
      scenario "With three todos" do
        todos = create_list(:todo, 3)      
        
        visit todos_path
        todo_els = page.all('.todo')

        expect(todo_els.length).to eq(todos.length)
      end

      scenario "With four todos" do
        todos = create_list(:todo, 4)

        visit todos_path
        todo_els = page.all('.todo')

        expect(todo_els.length).to eq(todos.length)
      end
    end

    feature 'The user should be able to see whether each todo is complete or not.' do
      scenario 'With 3 complete todos' do
        todos = create_list(:complete_todo, 3)
        
        visit todos_path
        complete_todo_els = page.all('.todo.complete')

        expect(complete_todo_els.length).to eq(todos.length)
      end

      scenario 'With 2 complete todos and 3 incomplete' do
        complete_todos = create_list(:complete_todo, 2)
        incomplete_todos = create_list(:todo, 3)

        visit todos_path

        complete_todo_els = page.all('.todo.complete')
        incomplete_todo_els = page.all('.todo.incomplete')
        
        expect(complete_todo_els.length).to eq(complete_todos.length)
        expect(incomplete_todo_els.length).to eq(incomplete_todos.length)
      end
    end
  end
end
