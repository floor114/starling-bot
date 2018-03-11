# frozen_string_literal: true

module Lunches
  class Formatter < ::BaseService
    def initialize(url, members)
      @url = url
      @members = members
    end

    def call
      members.each_with_object([]) do |member, orders|
        meals = select_meals(member)
        orders.push("-> #{member}:\n#{meals}") if meals.present?
      end.join("\n\n")
    end

    private

    attr_reader :url, :members

    def parsed_data
      @parsed_data ||= ::Lunches::Parser.call(url)
    end

    def select_meals(member)
      parsed_data.each_with_object([]) do |data, meals|
        meals << "* #{data[:meal].downcase};" if data[:members].include?(member)
      end.join("\n")
    end
  end
end
