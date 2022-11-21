class Room < ApplicationRecord
  belongs_to :category
  belongs_to :user
  belongs_to :address

  validates %i[name size category description user address image_url price], presence: true
end
