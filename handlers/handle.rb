# frozen_string_literal: true

class Handle < BaseService
  def initialize(message, bot)
    @message = message
    @bot = bot
    @command, @args = ::CommandParser.call(message.text)
  end

  def call
    return if message.text.blank? || command.blank?

    handler_class_name.constantize.call(message, bot, args)
  rescue NameError => e
    Application.logger.error("Unknown handler: #{handler_class_name} (#{e.message})")
  end


  private

  attr_reader :message, :bot, :command, :args

  def handler_class_name
    @handler_class_name ||= "Handlers::#{command.camelize}"
  end
end
