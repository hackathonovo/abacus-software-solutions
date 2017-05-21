class FeedItem < ApplicationRecord
  belongs_to :rescue_action

  after_create :after_create
  private

  def after_create
  	rescue_action.invites.each do |invite|
  		invite.rescuer.propagate_message("Obavijest od #{author}: #{text}")
  	end
  end
end
