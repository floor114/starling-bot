# frozen_string_literal: true

module Handlers
  class LunchMe < Lunch
    private

    def members
      [user.full_name]
    end
  end
end
