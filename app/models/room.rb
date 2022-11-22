class Room < ApplicationRecord
  validates :name, presence: true
  belongs_to :category
  belongs_to :user
  belongs_to :address

  accepts_nested_attributes_for :address
end
