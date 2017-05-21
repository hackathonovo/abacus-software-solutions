class AddPointsToRescueActionAreas < ActiveRecord::Migration[5.0]
  def change
    add_column :rescue_action_areas, :points, :text
  end
end
