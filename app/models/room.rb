class Room < ApplicationRecord
  validates :name, presence: true
  belongs_to :category
  belongs_to :user
  belongs_to :address
end
