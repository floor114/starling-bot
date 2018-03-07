# frozen_string_literal: true

module Handlers
  class Start < BaseHandler
    private

    def answer
      I18n.t('hello')
    end
  end
end
