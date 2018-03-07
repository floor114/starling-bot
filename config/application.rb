# frozen_string_literal: true

require 'rubygems'
require 'bundler'
require './config/environment'
Bundler.require(:default, Environment.current)

require './services/base_service'
require './handlers/base_handler'

Dir['./config/initializers/**/*.rb',
    './handlers/**/*.rb',
    './services/**/*rb'].each { |file| require file }

class Application
  class << self
    def run
      Initializers::Database.call
      Initializers::Localization.call
      Initializers::Bot.call
    end

    def logger
      @logger ||= Logger.new(STDOUT, Logger::DEBUG)
    end
  end
end
