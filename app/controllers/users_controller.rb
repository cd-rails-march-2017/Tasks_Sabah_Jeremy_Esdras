class UsersController < ApplicationController
  def new
  end

  def login
    if request.post?
      user = User.find_by(name:params[:name])
      puts "******************user**************"
      puts user
      if params[:password] == user.password
        session[:id] = user.id
        session[:name] = user.name
        redirect_to '/'
      else
          redirect_to '/users/login'
      end
    end
  end

  def create
    user = User.new(user_create)
    if user.valid?
      user.save
    else
      flash[:message] = user.errors.full_messages
      redirect_to '/users/login'
    end
  end

  private

  def user_create
    params.require(:user).permit(:name, :password)
  end


end
