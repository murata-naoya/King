class User < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :carts, dependent: :destroy
  has_many :destinations, dependent: :destroy
  has_many :review, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :last_name_characters, presence: true
  validates :first_name_characters, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :email, presence: true

  attachment :profile_image

  def full_name(user)
    user.last_name_characters + user.first_name_characters
  end

end
