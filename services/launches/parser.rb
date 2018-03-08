# frozen_string_literal: true

module Lunches
  class Parser < ::BaseService
    LUNCHES_SELECTOR = '#print > strong.mr_r_1'.freeze

    def initialize(url)
      @url = url
    end

    def call
      orders.map { |order| format_order(order) }
    end

    private

    attr_reader :url

    def doc
      @doc ||= Faraday.new(url: url).post do |request|
        request.body = { auth: { email: ENV['EMAIL'], password: ENV['PASSWORD'] } }
      end
    end

    def orders
      @orders ||= ::Nokogiri::HTML(doc.body).css(LUNCHES_SELECTOR)
    end

    def format_order(element)
      {
        meal: element.text.strip.tr(':', ''),
        members: element.next_sibling.text.tr("\t\n", '').strip.split(', ')
      }
    end
  end
end
