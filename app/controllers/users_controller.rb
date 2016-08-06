class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] ||= []
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
    @route = users_url
  end

  def show
    @user = current_user
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password2)
  end

end
