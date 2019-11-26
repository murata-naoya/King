class Order < ApplicationRecord
	has_many :order_items, dependent: :destroy
	belongs_to :user
	validate :add_error_sample

	def add_error_sample
    if option.blank?
      errors[:base] << "支払い方法が空欄です"
    end
  end
end
