# frozen_string_literal: true

class Environment
  def self.current
    @current ||= (ENV['RACK_ENV'] || 'development').to_sym
  end
end
