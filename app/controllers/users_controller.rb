class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def edit
    if current_user == @user
      @user.update()
    end
  end

  def update
    authorize @user
    if @user.update(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      render "edit"
    end
  end

  private

  def secure_params
    params.require(:user).permit(:designation, :company,
                                 :username)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
