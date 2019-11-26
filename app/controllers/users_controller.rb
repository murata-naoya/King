class UsersController < ApplicationController
before_action :check_user, only:[:show, :edit, :update, :destroy]
before_action :check_logged_in, only:[:revive_page, :revive]
  def top
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params_user)
       flash[:notice] = "ユーザー情報が更新されました"
       redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def destroy
    user = User.find(params[:id])
    user.discard
    flash[:notice] = "退会しました"
    redirect_to new_user_session_path
  end

  def revive_page
    @user = User.new
  end

  def revive
    user = User.with_discarded.find_by(email: params_user[:email])
    if user.nil?
      flash[:notice] = "有効なメールアドレスではありません"
      redirect_to revive_page_path
    elsif user.discarded_at.nil?
      flash[:notice] = "すでに存在しているアカウントです"
      redirect_to new_user_session_path
    else
      if user.valid_password?(params_user[:password])
        user.undiscard
        flash[:notice] = "アカウントが復元されました"
        redirect_to new_user_session_path
      else
        flash[:notice] = "有効ではないパスワードです"
        redirect_to revive_page_path
      end
    end
  end

  private
  def params_user
    params.require(:user).permit(:last_name_characters, :first_name_characters, :last_name_kana,
      :first_name_kana, :email, :profile_image, :postal_code, :address, :phone_number, :password)
  end

end
