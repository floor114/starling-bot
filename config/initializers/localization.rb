# frozen_string_literal: true

module Initializers
  class Localization < ::BaseService
    def call
      I18n.load_path = locales
      I18n.locale = default_locale
      I18n.backend.load_translations
    end

    private

    def locales
      Dir['./config/locales/*.yml']
    end

    def default_locale
      :en
    end
  end
end
