# frozen_string_literal: true

module Lunches
  class Formatter < ::BaseService
    def initialize(url, members)
      @url = url
      @members = members
    end

    def call
      data.each_with_object([]) do |(member, meals), orders|
        meals = meals.map { |meal| I18n.t('lunch.meal', meal: meal) }.join("\n")

        orders.push("-> #{member}:\n#{meals}")
      end.join("\n\n")
    end

    def data
      @data ||= members.each_with_object(Hash.new([])) do |member, hash|
        meals = select_meals(member)

        hash[member] = hash[member].concat(meals) if meals.present?
      end
    end

    private

    attr_reader :url, :members

    def parsed_data
      @parsed_data ||= ::Lunches::Parser.call(url)
    end

    def select_meals(member)
      parsed_data.each_with_object([]) do |data, meals|
        meals << data[:meal].downcase if data[:members].any? { |e| e.downcase[member.downcase] }
      end
    end
  end
end
