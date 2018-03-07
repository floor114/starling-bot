# frozen_string_literal: true

module Initializers
  class Bot < ::BaseService
    def call
      Application.logger.info("Running bot...")
      Telegram::Bot::Client.run(ENV['TOKEN']) do |bot|
        bot.listen do |message|
          Application.logger.info("Received `#{message.text}` from @#{message.from.username}.")
          Handle.call(message, bot)
        end
      end
    end
  end
end
