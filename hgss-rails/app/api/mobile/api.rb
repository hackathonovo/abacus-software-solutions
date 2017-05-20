module Mobile
  class API < Grape::API
    format :json
 
    params do
      requires :point_id, type: Integer, desc: 'ID of the point we want to get info about.'
    end
    get 'points/:point_id' do
      point_id = params[:point_id]
      point = Point.find(point_id)
    end

    params do
      requires :recording, type: File
    end
    post 'sessions' do
      temp_file = params[:recording][:tempfile]

      sesssion = AppSession.new(:recording => temp_file)
      sesssion.save
    end
  end
end