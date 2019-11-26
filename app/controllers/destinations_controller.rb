class DestinationsController < ApplicationController
before_action :check_user

  def update
    @destination = Destination.find_by(user_id: current_user)
    if @destination.update(params_destination)
      redirect_to order_final_path
    else
      render "order_items/index"
    end
  end

  private
  def params_destination
    params.require(:destination).permit(:address_name, :postal_code, :address, :phone_number)
  end
end
