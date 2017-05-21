class CreateRescueActions < ActiveRecord::Migration[5.0]
  def change
    create_table :rescue_actions do |t|
      t.integer :lead_id
      t.boolean :is_search
      t.integer :kind
      t.float :start_position_latitude
      t.float :start_position_longitude
      t.text :description

      t.timestamps
    end
  end
end
