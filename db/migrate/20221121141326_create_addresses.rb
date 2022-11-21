class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.integer :number
      t.string :road
      t.string :city
      t.string :country

      t.timestamps
    end
  end
end
