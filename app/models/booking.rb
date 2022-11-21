class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates %i[start_date end_date user room], presence: true
end
