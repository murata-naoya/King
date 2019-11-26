class Product < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }
  has_many :arrivals, dependent: :destroy
  has_many :discs, dependent: :destroy
  accepts_nested_attributes_for :discs, allow_destroy: true
  has_many :songs, through: :discs
  has_many :carts, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :reviews, dependent: :destroy

  attachment :jacket_image

  belongs_to :artist
  belongs_to :label
  belongs_to :genre

  validates :product_name, presence:true
  validates :cd_type, presence:true
  validates :price, presence:true, numericality: {greater_than: 0}
  # validates :stock, presence:true
  validates :sell_status, presence:true

  def stock
    arrivals_count = 0
    buy = 0

    self.arrivals.each do |a|
      arrivals_count += a.arrival_count
    end

    self.order_items.each do |i|
      buy += i.count
    end

    return arrivals_count - buy
  end

  def self.search(search)
    if search
       where(['product_name LIKE ?', "%#{search}%"])
    else
       all
    end
 end

end
