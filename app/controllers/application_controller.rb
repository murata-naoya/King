class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name_characters, :first_name_characters, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number])
  end

  def after_sign_in_path_for(resource)
    if user_signed_in?
      user_path(current_user)
    elsif admin_signed_in?
      admin_products_path
    else
    end
  end

  def after_sign_up_path_for(resource)
      user_path(current_user)
  end


  def check_admin
  if admin_signed_in?
  elsif user_signed_in?
    if current_user.role != 'admin'
      redirect_to root_path
    end
  else
    flash[:notice] = "有効なアカウントではありません"
    redirect_to root_path
  end
  end

  def check_user
    if user_signed_in?
    else
      flash[:notice] = "有効なアカウントではありません"
      redirect_to new_user_session_path
    end
  end

  def check_logged_in
    if user_signed_in?
      redirect_to user_path(current_user)
    end
  end
end
