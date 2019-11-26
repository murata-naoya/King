class Admin::UsersController < ApplicationController
before_action :check_admin

    def index
        @users = User.with_discarded
    end

    def show
        @user = User.with_discarded.find_by(id: params[:id])
    end

    def edit
        @user = User.with_discarded.find_by(id: params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(params_user)
           flash[:notice] = "ユーザー情報が更新されました"
           redirect_to admin_user_path(@user)
        else
          render "edit"
        end
    end

    def destroy
      user = User.find(params[:id])
      user.discard
      flash[:notice] = "退会しました"
      redirect_to admin_users_path
    end

    private
    def params_user
      params.require(:user).permit(:last_name_characters, :first_name_characters, :last_name_kana,
        :first_name_kana, :email, :profile_image, :postal_code, :address, :phone_number, :password)
    end
end
