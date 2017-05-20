class Rescuer < ApplicationRecord
	def name
  		[first_name, last_name].compact.join(" ")
	end

	has_and_belongs_to_many :specialties
end
