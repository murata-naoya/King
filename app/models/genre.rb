class Genre < ApplicationRecord
	include Discard::Model
  	default_scope -> { kept }
	has_many :products
	validates :name, presence:true
end
