# frozen_string_literal: true

module Fetchers
  class BaseFetcher < ::BaseService
    def initialize(api_object)
      @api_object = api_object
    end

    def call
      record.tap { |record| record.update(attributes) if updateable? }
    end

    private

    attr_reader :api_object

    def record
      @record ||= klass.find_or_create_by(find_key => attributes.delete(find_key))
    end

    def attributes
      @attributes ||= fetch_attributes
    end

    def fetch_attributes
      api_object.to_h.slice(*klass.attribute_names.map(&:to_sym)).tap do |attrs|
        attrs[:telegram_id] = attrs.delete(:id)
      end
    end

    def klass
      @klass ||= self.class.name.demodulize.constantize
    end

    def updateable?
      attributes.any? { |k, v| record.public_send(k) != v }
    end

    def find_key
      :telegram_id
    end
  end
end
