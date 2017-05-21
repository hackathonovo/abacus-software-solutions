class CreateRescueMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :rescue_members do |t|
      t.belongs_to :rescuer, foreign_key: true

      t.timestamps
    end
  end
end
