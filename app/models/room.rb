class Room < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :address
  has_many :bookings, dependent: :destroy
  has_one_attached :photo

  accepts_nested_attributes_for :address
  validates :name, presence: true
  validates :size, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :category_id, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
