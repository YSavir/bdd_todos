class TodosController < ApplicationController

  def index
    @todos = Todo.all
    @todo = Todo.new
  end

  def create
    todo = Todo.create(todo_params)

    redirect_to todo_path(todo)
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def edit
    @todo = Todo.find(params[:id]) 
  end
  
  def update
    todo = Todo.find(params[:id])
    todo.update(todo_params)

    redirect_to todo_path(todo)  
  end

  def destroy
    Todo.destroy params[:id]
    redirect_to todos_path
  end

  def toggle_completeness
    todo = Todo.find(params[:id])
    todo.toggle_completeness

    redirect_to :back
  end

  private

  def todo_params
    params.require(:todo).permit(:title)
  end

end
