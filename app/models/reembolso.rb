class Reembolso < ApplicationRecord
  belongs_to :user

  validates :descricao, presence: true
  validates :valor, presence: true, numericality: { greater_than: 0 }
  validates :data, presence: true
end
