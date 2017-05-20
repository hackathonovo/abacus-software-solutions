class Rescuer < ApplicationRecord
	def name
  		[first_name, last_name].compact.join(" ")
	end

	has_and_belongs_to_many :specialties

	searchable do
		text :availability
		text :name
    	text :address_home
    	text :address_work
    	text :specialties do
      		specialties.map { |specialty| specialty.name }
    	end
	end

	enum level: [:pridruzeni_clan, :pripravnik, :gorski_spasavatelj]

	has_and_belongs_to_many :rescue_action_areas
	has_many :invites

	acts_as_mappable :default_units => :meters,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :home_latitude,
                   :lng_column_name => :home_longitude
end
