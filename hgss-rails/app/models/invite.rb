class Invite < ApplicationRecord
  belongs_to :rescue_action
  belongs_to :rescuer
  enum status: [:unanswered, :accepted, :denied]
end
