class Admin::UsersController < AdminController
  before_action :user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order(:email).page(params[:page]).per(10)
  end

  def show
  end
  
  def edit
  end

  def create
    new_user = User.new(user_params)
    new_user.company = current_company
    if new_user.save
      return redirect_to admin_users_path, notice: "User Behasil dibuat"
    end

    redirect_to admin_users_path, alert: new_user.errors.full_messages.join(", ")
  end

  def update
    if user.update(user_params)
      return redirect_to admin_users_path, notice: "User Behasil diupdate"
    end

    redirect_to admin_users_path, alert: user.errors.full_messages.join(", ")
  end

  def destroy
    if user.destroy
      return redirect_to admin_users_path, notice: "User berghasil dihapus"
    end

    redirect_to admin_users_path, alert: user.errors.full_messages.join(", ")
  end

  private
  def user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
