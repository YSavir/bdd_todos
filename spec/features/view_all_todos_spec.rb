require 'rails_helper'

RSpec::Matchers.define :contain do |expected|
  match do |actual|
    @actual_todos.length == expected
  end
  chain :complete_todos do
    @type = 'complete'
    @actual_todos = subject.select do |el|
      el['class'].match(/(\s|^)complete/)
    end
  end

  chain :incomplete_todos do
    @type = 'incomplete'
    @actual_todos = subject.select do |el|
      el['class'].match(/(\s|^)incomplete/)
    end
  end
  failure_message do |actual|
    "expected to find #{expected} #{@type} todos but found #{@actual_todos.length} #{@type} todos instead"
  end
  description do
    "have #{expected} complete todos"
  end
end

RSpec.feature "ViewAllTodos", type: :feature do
  context 'When viewing the index page' do
    let (:todo_els) { page.all('.todo') }
    let (:complete_todo_els) { page.all('.todo.complete') }
    let (:incomplete_todo_els) {page.all('.todo.incomplete') }
    subject { todo_els }
    
    context 'and there are three todos' do
      let! (:todos) { create_list(:todo, 3) }
      before { visit todos_path }

      it { should have_exactly(3).items }
    end

    context 'and there are four todos' do
      let! (:todos) { create_list(:todo, 4) }
      before { visit todos_path }

      it { should have_exactly(4).items }
    end

    context 'and there are four complete todos and three incomplete todos' do
      let! (:complete_todos) { create_list(:complete_todo, 4) }
      let! (:incomplete_todos) { create_list(:todo, 3) }
      before { visit todos_path }
      
      it { should have_exactly(7).todos }
      it { should contain(4).complete_todos }
      it { should contain(3).incomplete_todos }

      context 'and I click to complete an incomplete todo' do
        before do
          page.first('.complete-button').click
        end
        specify { expect(page.current_path).to eq(todos_path) }
        it { should contain(5).complete_todos }
        it { should contain(2).incomplete_todos }
      end
    end
  
  end
end



=begin

  feature 'When viewing the index page' do
    let! (:complete_todos) { }
    let! (:incomplete_todos) { Todo.where(complete: false) }
    before { @completeTodo.where(complete: true) }


    let (:complete_todos) { create_list(:complete_todo, 3) }
    let (:incomplete_todos) { create_list(:todo, 3) }
    scenario 'the user should be able to complete todos' do
      visit todos_path
      puts page.all('.todo.incomplete').length
      page.all('.todo.incomplete').each do |todo_el|
        puts todo_el.find('Complete Todo')
        click_button todo_el.find('Complete Todo')
      end

      complete_todo_els = page.all('.todo.complete')

      expect(complete_todo_els.length).to eq(complete_todos.length + incomplete_todos.length)
    end
  end
end
=end
