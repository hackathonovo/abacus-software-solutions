class RescueAction < ApplicationRecord
  	has_many :invites, dependent: :destroy
	has_many :feed_items, dependent: :destroy
	has_many :rescue_action_areas, dependent: :destroy

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


	def propagate_invites
		invites.each do |invite|
			invite.rescuer.propagate_message("Pokrenuta je akcija spašavanja, da li ste dostupni?")
		end
	end
end
