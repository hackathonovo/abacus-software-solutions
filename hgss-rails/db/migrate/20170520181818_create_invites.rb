class CreateInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :invites do |t|
      t.references :rescue_action, foreign_key: true
      t.integer :rescuer_id
      t.integer :status

      t.timestamps
    end
  end
end
