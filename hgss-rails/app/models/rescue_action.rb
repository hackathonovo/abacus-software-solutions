class RescueAction < ApplicationRecord
	# Number of items per page.
	paginates_per 15

    # Default scope so you don't have to order everytime.
	default_scope -> { order('updated_at DESC') }

	belongs_to :lead, class_name: "Rescuer"
end
