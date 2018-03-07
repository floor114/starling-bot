# frozen_string_literal: true

module Handlers
  class BaseHandler < ::BaseService
    def initialize(message, bot, args)
      @message = message
      @bot = bot
      @args = args
    end

    def call
      bot.api.send_message(chat_id: message.chat.id, text: answer)
      Application.logger.info("Sended message to @#{message.chat.username}")
    end

    private

    attr_reader :message, :bot, :args

    def answer
      raise NotImplementedError
    end
  end
end
