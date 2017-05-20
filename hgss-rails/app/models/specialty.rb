class Specialty < ApplicationRecord
	searchable do
		text :name
	end
end
