# frozen_string_literal: true

module Handlers
  class Help < BaseHandler
    private

    def answer
      I18n.t('help')
    end
  end
end
