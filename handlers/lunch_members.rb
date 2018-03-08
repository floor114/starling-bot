# frozen_string_literal: true

module Handlers
  class LunchMembers < BaseHandler
    private
    private *(delegate :members, to: :lunch)

    def answer
      return I18n.t('lunch.members.not_found') if not_found?

      I18n.t('lunch.members.added', members: members.join(', '))
    end

    def not_found?
      members.blank?
    end

    def lunch
      @lunch ||= ::Lunch.find_or_create_by(chat_id: chat.id)
    end
  end
end
