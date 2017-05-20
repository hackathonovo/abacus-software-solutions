class CreateFeedItems < ActiveRecord::Migration[5.0]
  def change
    create_table :feed_items do |t|
      t.references :rescue_action, foreign_key: true
      t.text :text
      t.string :author

      t.timestamps
    end
  end
end
