class AddZipCodeToAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :zip_code, :integer
  end
end
