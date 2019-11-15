# frozen_string_literal: true

module Lunches
  class Check < ::BaseService
    def initialize(members)
      @members = members
    end

    def call
      return if members.blank?

      I18n.t('lunch.members.without_lunch', members: members_to_show)
    end

    private

    attr_reader :members

    def members_to_show
      members.each_with_object([]) do |member, array|
        array << member unless lunch?(member)
      end.join(', ')
    end

    def obedi_orders
      @obedi_orders ||= ::Lunches::Formatter.new("#{ENV['OBEDI_URL']}&d=1", members).data
    end

    def kolo_smaku_orders
      @kolo_smaku_orders ||= ::Lunches::Formatter.new("#{ENV['KOLO_SMAKU_URL']}&d=1", members).data
    end

    def moms_kitchen_orders
      @moms_kitchen_orders ||= ::Lunches::Formatter.new("#{ENV['MOMS_KITCHEN_URL']}&d=1", members).data
    end

    def lunch?(member)
      [obedi_orders, kolo_smaku_orders, moms_kitchen_orders].any? { |hash| hash.keys.include?(member) }
    end
  end
end
