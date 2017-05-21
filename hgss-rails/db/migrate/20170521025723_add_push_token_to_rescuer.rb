class AddPushTokenToRescuer < ActiveRecord::Migration[5.0]
  def change
    add_column :rescuers, :push_token, :string
  end
end
