class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(params[:user][:email],
                                    params[:user][:password])

    if user
      login!(user)
      redirect_to user_url(user)
    else
      @user = User.new(user_params)
      flash.now[:errors] ||= []
      flash.now[:errors] += ["User name or password incorrect"]
      render :new
    end
  end

  def new
    @user = User.new
    @route = session_url
  end

  def destroy
    logout
    redirect_to new_session_url
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
