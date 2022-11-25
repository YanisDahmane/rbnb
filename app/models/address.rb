class Address < ApplicationRecord
  validates :number, presence: true
  validates :road, presence: true
  validates :city, presence: true
  validates :country, presence: true
  validates :zip_code, presence: true
end
