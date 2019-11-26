class Arrival < ApplicationRecord
	belongs_to :product
	validates :arrival_count, presence:true, numericality: {greater_than: 0}
	validates :arrival_date, presence:true
end
