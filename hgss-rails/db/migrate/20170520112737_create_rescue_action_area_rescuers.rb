class CreateRescueActionAreaRescuers < ActiveRecord::Migration[5.0]
  def change
    create_table :rescue_action_area_rescuers do |t|
      t.belongs_to :rescue_action_area, foreign_key: true
      t.belongs_to :rescuer, foreign_key: true

      t.timestamps
    end
  end
end
