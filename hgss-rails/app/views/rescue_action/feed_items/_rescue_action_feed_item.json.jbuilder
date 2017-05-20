json.extract! rescue_action_feed_item, :id, :text, :author, :created_at, :updated_at
json.url rescue_action_feed_item_url(rescue_action_feed_item, format: :json)
