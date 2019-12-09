# frozen_string_literal: true

module Handlers
  class BaseHandler < Bionic::Handler
    def call
      perform_action
      super
    rescue
    end

    private

    attr_reader :message, :bot, :args

    def user
      @user ||= ::Fetchers::User.call(message.from)
    end

    def chat
      @user ||= ::Fetchers::Chat.call(message.chat)
    end

    def perform_action; end
  end
end
