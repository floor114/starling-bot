# frozen_string_literal: true

module Handlers
  class BaseHandler < ::BaseService
    def initialize(message, bot, args)
      @message = message
      @bot = bot
      @args = args
    end

    def call
      perform_action
      bot.api.send_message(chat_id: message.chat.id, text: answer)
      Application.logger.info("Sended message to @#{message.chat.username}")
    end

    private

    attr_reader :message, :bot, :args

    def user
      @user ||= ::Fetchers::User.call(message.from)
    end

    def chat
      @user ||= ::Fetchers::Chat.call(message.chat)
    end

    def answer
      raise NotImplementedError
    end

    def perform_action; end
  end
end
