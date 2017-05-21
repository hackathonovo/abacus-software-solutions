class CreateJoinTableRescueActionAreaRescuers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :rescue_action_areas, :rescuers do |t|
      # t.index [:rescue_action_area_id, :rescuer_id]
      # t.index [:rescuer_id, :rescue_action_area_id]
    end
  end
end
