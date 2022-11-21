class Address < ApplicationRecord
  validates %i[number road city country zip_code], presence: true
end
