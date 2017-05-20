class CreateRescuersSpecialties < ActiveRecord::Migration[5.0]
  def change
    create_table :rescuers_specialties do |t|
      t.references :rescuer, foreign_key: true
      t.references :specialty, foreign_key: true
    end
  end
end
