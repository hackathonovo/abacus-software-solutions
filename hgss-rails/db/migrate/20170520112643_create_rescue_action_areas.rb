class CreateRescueActionAreas < ActiveRecord::Migration[5.0]
  def change
    create_table :rescue_action_areas do |t|
      t.belongs_to :rescue_action, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
