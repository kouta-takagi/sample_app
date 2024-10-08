class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update]
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params) # 実装は終わっていないことに注意!
    if @user.save
      reset_session
      log_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = 'Please log in.'
    redirect_to login_url, status: :see_other
  end
end
