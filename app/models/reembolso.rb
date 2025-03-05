class Reembolso < ApplicationRecord
  belongs_to :user
  has_many :reembolso_tags, dependent: :destroy
  has_many :tags, through: :reembolso_tags

  validates :descricao, presence: true
  validates :valor, presence: true, numericality: { greater_than: 0 }
  validates :data, presence: true
end
