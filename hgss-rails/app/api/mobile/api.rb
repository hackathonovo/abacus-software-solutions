def render_rescue_action(rescue_action)
  team_members = rescue_action.invites.map do |i|
    {
      :id => i.id,
      :name => i.rescuer.name,
      :phone_number => i.rescuer.phone_number,
      :status => i.status
    }
  end
  
  { :data => {
    :id => rescue_action.id,
    :location => {
      :latitude => rescue_action.start_position_latitude,
      :longitude => rescue_action.start_position_longitude
    },
    :leader => {
      :name => rescue_action.lead.name,
      :phone_number => rescue_action.lead.phone_number
    },
    :team_members => team_members,
    :start_time => rescue_action.created_at.to_time.to_i,
    :description => rescue_action.description
  }}
end

def render_feed_item(feed_item)
  {
    :id => feed_item.id,
    :rescue_id => feed_item.rescue_action_id,
    :text => feed_item.text,
    :author => feed_item.author,
    :created_at => feed_item.created_at.to_time.to_i,
    :updated_at => feed_item.updated_at.to_time.to_i
  }
end

def render_feed_items(feed_items)
  map = feed_items.map do |feed_item|
    render_feed_item(feed_item)
  end
  map
end

module Mobile
  class API < Grape::API
    format :json

 
    params do
      requires :rescue_action_id, type: Integer
    end
    get 'feed/:rescue_action_id' do
      header 'Cache-Control', 'no-cache, no-store, must-revalidate'
      header 'Pragma', 'no-cache'
      header 'Expires', '0'
      rescue_action_id = params[:rescue_action_id]
      rescue_action = RescueAction.find(rescue_action_id)
      {:data => render_feed_items(rescue_action.feed_items) }
    end

    

    params do
      requires :rescue_action_id, type: Integer
    end
    get 'detail/:rescue_action_id' do
      header 'Cache-Control', 'no-cache, no-store, must-revalidate'
      header 'Pragma', 'no-cache'
      header 'Expires', '0'
      rescue_action_id = params[:rescue_action_id]
      rescue_action = RescueAction.find(rescue_action_id)
      render_rescue_action(rescue_action)
    end

    params do
      requires :rescuer_id, type: Integer
    end
    get 'map/:rescuer_id' do
      header 'Cache-Control', 'no-cache, no-store, must-revalidate'
      header 'Pragma', 'no-cache'
      header 'Expires', '0'
      rescuer_id = params[:rescuer_id]
      rescuer = Rescuer.find(rescuer_id)
      rescue_invite = rescuer.invites.first
      rescue_action = rescue_invite.rescue_action if not rescue_invite.nil?
      return {} if rescue_invite.nil?

      area = rescuer.rescue_action_areas.where(rescue_action: rescue_action).first if not rescue_action.nil?
      polygon_points = nil
      polygon_points = JSON.parse(area.points) if not area.nil?

      {:data => {
        :location => {
          :latitude => rescue_action.start_position_latitude,
          :longitude => rescue_action.start_position_longitude
        },

        :polygon => polygon_points
      }}
    end

    params do
      requires :query, type: String
      requires :latitude, type: Float
      requires :longitude, type: Float
    end
    get 'rescuers/:query' do
      header 'Cache-Control', 'no-cache, no-store, must-revalidate'
      header 'Pragma', 'no-cache'
      header 'Expires', '0'
      query = params[:query]
      latitude = params[:latitude]
      longitude = params[:longitude]
      search = Rescuer.search do
        fulltext query
      end

      sr = search.results.map do |r|
        {
          :id => r.id,
          :name => r.name,
          :phone_number => r.phone_number,
          :distance => Geocoder::Calculations.distance_between([latitude,longitude], [r.home_latitude,r.home_longitude])
        }
      end

      {:data => sr}
    end

    params do
      requires :rescuer_id, type: Integer
    end
    get 'invites/for/:rescuer_id' do
      header 'Cache-Control', 'no-cache, no-store, must-revalidate'
      header 'Pragma', 'no-cache'
      header 'Expires', '0'
      invites = Invite.where({:rescuer_id => params[:rescuer_id]})
      invites_mapped = invites.map do |i|
        {
          :id => i.id,
          :rescue_action_id => i.rescue_action_id,
          :status => i.status
        }
      end
      {:data => invites_mapped}
    end

    params do
      requires :rescuer_id, type: Integer
      requires :status, type: Integer
    end
    post 'invites/:rescuer_id' do
      header 'Cache-Control', 'no-cache, no-store, must-revalidate'
      header 'Pragma', 'no-cache'
      header 'Expires', '0'
      invite = Invite.find(params[:rescuer_id])
      invite.status = params[:status]
      invite.save!

      {:data => {
          :id => invite.id,
          :rescue_action_id => invite.rescue_action_id,
          :status => invite.status
        }}
    end

    params do
      requires :description, type: String
      requires :lead_id, type: Integer
      requires :kind, type: Integer
      requires :start_position_latitude, type: Float
      requires :start_position_longitude, type: Float
      requires :rescuer_ids, type: Array[Integer], coerce_with: ->(val) { val.split(",") }
    end
    post 'rescue_actions' do
      header 'Cache-Control', 'no-cache, no-store, must-revalidate'
      header 'Pragma', 'no-cache'
      header 'Expires', '0'
      description = params[:description]
      lead_id = params[:lead_id]
      kind = params[:kind]
      start_position_latitude = params[:start_position_latitude]
      start_position_longitude = params[:start_position_longitude]
      rescuer_ids = params[:rescuer_ids]

      rescue_action = RescueAction.new({
        :description => description, 
        :lead_id => lead_id, 
        :kind => kind, 
        :start_position_latitude => start_position_latitude,
        :start_position_longitude => start_position_longitude
      })

      rescuer_ids.each do |rescuer_id|
        #require 'pry'; binding.pry
        invite = Invite.new({:rescuer_id => rescuer_id, :rescue_action_id => rescue_action.id, :status => 0})
        rescue_action.invites << invite
      end

      rescue_action.save!
      rescue_action.propagate_invites

      render_rescue_action(rescue_action)
    end

    params do
      requires :id, type: Integer
      requires :text, type: String
      requires :author, type: String
    end
    post 'rescue_action/:id' do
      header 'Cache-Control', 'no-cache, no-store, must-revalidate'
      header 'Pragma', 'no-cache'
      header 'Expires', '0'
      rescue_action_id = params[:id]
      text = params[:text]
      author = params[:author]

      rescue_action = RescueAction.find(rescue_action_id)
      feed_item = FeedItem.new({:rescue_action => rescue_action, :text => text, :author => author})
      feed_item.save!
      {:data => feed_item}
    end
  end
end