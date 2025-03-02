class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  include DeviseTokenAuth::Concerns::User

  validates :password, presence: true, if: -> { new_record? && encrypted_password.blank? }

  has_many :reembolsos, dependent: :destroy 
end
