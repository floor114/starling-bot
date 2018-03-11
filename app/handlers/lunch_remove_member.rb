# frozen_string_literal: true

module Handlers
  class LunchRemoveMember < LunchMembers
    private

    def perform_action
      members.reject! { |member| args.include?(member) }
      lunch.save
    end

    def not_found?
      args.blank? || members.blank?
    end
  end
end
