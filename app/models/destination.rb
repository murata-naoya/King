class Destination < ApplicationRecord
  belongs_to :user

  validates :address_name, presence:true
  validates :postal_code, presence:true
  validates :address, presence:true
  validates :phone_number, presence:true
end
