class CreateJoinTableAreaRescuers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :areas, :rescuers do |t|
      # t.index [:area_id, :rescuer_id]
      # t.index [:rescuer_id, :area_id]
    end
  end
end
