class CreateRescueMemberLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :rescue_member_locations do |t|
      t.belongs_to :rescue_member, foreign_key: true
      t.datetime :location_on
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
