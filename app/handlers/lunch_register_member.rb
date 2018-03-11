# frozen_string_literal: true

module Handlers
  class LunchRegisterMember < LunchMembers
    private

    def perform_action
      members.push(*args).uniq!
      lunch.save
    end

    def not_found?
      args.blank?
    end
  end
end
