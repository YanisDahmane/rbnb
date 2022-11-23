class Room < ApplicationRecord
  validates :name, presence: true
  belongs_to :category
  belongs_to :user
  belongs_to :address
  has_many :bookings
  has_one_attached :photo

  accepts_nested_attributes_for :address
end
