class TodosController < ApplicationController

  def index
    @todo = Todo.new
  end

  def create
    todo = Todo.create(todo_params)

    redirect_to todo_path(todo)
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def toggle_completeness
    todo = Todo.find(params[:id])
    todo.toggle_completeness

    redirect_to todo_path(todo)
  end

  private

  def todo_params
    params.require(:todo).permit(:title)
  end

end
