module Meetings
  class Model < Ohm::Model

    attribute :created_at
    attribute :updated_at
    attribute :title
    attribute :starts_at
    attribute :duration
    attribute :instructions

  end
end
