class TodosController < ApplicationController
  def index
    user = User.find(session[:id])
    @todos = user.to_dos.order(:due)
    session[:toggle] ||= false
  end

  def new
  end

  def create
    @todos = ToDo.new(todo_params)
    @todos.isdone = false
    @todos.user_id = session[:id]
    if @todos.save
      redirect_to '/', notice: 'You have created a new todo item!'
    else
      flash[:errors] = @todos.errors.full_messages
      redirect_to :back
    end
  end

  def update
    @todo = ToDo.find(params[:id])
    if @todo.isdone == true
      @todo.isdone = false
    else
      @todo.isdone = true
    end
    @todo.save
    redirect_to '/'
  end

  def toggle
    if session[:toggle] == true
      session[:toggle] = false
    else
      session[:toggle] = true
    end
    redirect_to :back
  end

  private

    def todo_params
      params.require(:todos).permit(:title, :due)
    end

end
