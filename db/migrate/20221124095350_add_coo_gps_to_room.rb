class AddCooGpsToRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :addresses, :coo_gps_lat, :float
    add_column :addresses, :coo_gps_long, :float
  end
end
