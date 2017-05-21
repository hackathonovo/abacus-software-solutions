class CreateRescuers < ActiveRecord::Migration[5.0]
  def change
    create_table :rescuers do |t|
      t.string :first_name
      t.string :last_name
      t.text :availability
      t.string :phone_number
      t.string :address_home
      t.float :home_latitude
      t.float :home_longitude
      t.string :address_work
      t.float :work_latitude
      t.float :work_longitude
      t.integer :level

      t.timestamps
    end
  end
end
