class AddLatitudeLongitudeZoomLevelToRescueActionArea < ActiveRecord::Migration[5.0]
  def change
    add_column :rescue_action_areas, :latitude, :float
    add_column :rescue_action_areas, :longitude, :float
    add_column :rescue_action_areas, :zoom_level, :float
  end
end
