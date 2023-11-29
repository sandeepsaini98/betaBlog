class Users::SessionsController < ApplicationController
  before_action :get_user, only: [:login_in]
  before_action :authenticate_user, only: [:login_in]

  def create
    @rv = User.create_new(user_params)
    return @rv if (@rv[:error])

    @user = @rv[:user]
    redirect_to root_path, notice: 'Sign up successful!'
  end
  
  def login_in
    session[:user_id] = @user.id
    redirect_to root_path, notice: 'Login successful'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def get_user
    @user = User.find_by(email: params[:user][:email])

    if (@user.nil?)
      render json: { error: true, message: "No user found for specified email", code: 1234567 }
      return
    end

    return { success: true, users: @user }
  end

  def authenticate_user
    if @user && @user.authenticate(params[:user][:password])
      login_in
    else
      flash.now[:alert] = 'Invalid password'
      render :new
    end
  end
end #__End of UsersController