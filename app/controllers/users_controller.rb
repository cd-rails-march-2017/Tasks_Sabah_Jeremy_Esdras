class UsersController < ApplicationController
  def new
  end

  def login
    if request.post?
      flash[:message] = []
      user = User.find_by(name:params[:name])
      if user
        if params[:password] == user.password
          session[:id] = user.id
          session[:name] = user.name
          redirect_to '/'
        else
          flash[:message].push("invalid password")
          redirect_to '/users/login'
        end
      else
          flash[:message].push("user not in database")
          redirect_to '/users/login'
      end
    end
  end

  def create
      user = User.new(user_create)
      if user.valid?
        user.save
        redirect_to '/'
      else
        flash[:message] = user.errors.full_messages
        redirect_to '/users/login'
      end
  end

  def logout
    reset_session
    redirect_to '/users/login'
  end

  private

  def user_create
    params.require(:user).permit(:name, :password)
  end


end
