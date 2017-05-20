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
	end

	enum level: [:pridruzeni_clan, :pripravnik, :gorski_spasavatelj]
end
