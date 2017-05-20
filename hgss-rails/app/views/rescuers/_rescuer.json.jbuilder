json.extract! rescuer, :id, :first_name, :last_name, :availability, :phone_number, :address_home, :home_latitude, :home_longitude, :address_work, :work_latitude, :work_longitude, :level, :created_at, :updated_at
json.url rescuer_url(rescuer, format: :json)
