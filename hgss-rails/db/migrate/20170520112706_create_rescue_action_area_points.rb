class CreateRescueActionAreaPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :rescue_action_area_points do |t|
      t.belongs_to :rescue_action_area, foreign_key: true
      t.float :latitude
      t.float :longitude
      t.integer :index

      t.timestamps
    end
  end
end
