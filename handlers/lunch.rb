# frozen_string_literal: true

module Handlers
  class Lunch < BaseHandler
    private
    private *(delegate :members, to: :lunch)

    def answer
      return I18n.t('lunch.members.not_found') if members.blank?
      return I18n.t('lunch.not_found') if obedi_orders.blank? && kolo_smaku_orders.blank?

      [].tap do |answer|
        answer.push("#{I18n.t('lunch.obedi')}\n#{obedi_orders}") if obedi_orders.present?
        answer.push("#{I18n.t('lunch.kolo_smaku')}\n#{kolo_smaku_orders}") if kolo_smaku_orders.present?
      end.join("\n\n")
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
  end
end
