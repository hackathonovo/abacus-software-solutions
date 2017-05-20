class RescueAction < ApplicationRecord
	# Number of items per page.
	paginates_per 15

    # Default scope so you don't have to order everytime.
	default_scope -> { order('updated_at DESC') }

	belongs_to :lead, class_name: "Rescuer"

	searchable do
		text :description
		text :lead_name do
      		lead.name
    	end

		string :description
	end

	enum kind: [:search, :rescue]
end
