# frozen_string_literal: true

module Handlers
  class LunchCheck < BaseHandler
    private

    def answer
      return I18n.t('lunch.members.not_found') if members.blank?

      Lunches::Check.call(members)
    end

    def members
      @members ||= args.empty? ? lunch.members : args
    end

    def lunch
      @lunch ||= ::Lunch.find_or_create_by(chat_id: chat.id)
    end

    def obedi_orders
      @obedi_orders ||= ::Lunches::Formatter.call(ENV['OBEDI_URL'], members)
    end

    def kolo_smaku_orders
      @kolo_smaku_orders ||= ::Lunches::Formatter.call(ENV['KOLO_SMAKU_URL'], members)
    end

    def moms_kitchen_orders
      @moms_kitchen_orders ||= ::Lunches::Formatter.call(ENV['MOMS_KITCHEN_URL'], members)
    end
  end
end
