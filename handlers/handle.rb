# frozen_string_literal: true

class Handle < BaseService
  COMMAND_REGEX = %r[\/[a-z,_]+]

  def initialize(message, bot)
    @message = message
    @bot = bot
  end

  def call
    return if message.text.blank? || command.blank?

    handler_class_name.constantize.call(message, bot, args)
  rescue NameError => e
    Application.logger.error("Unknown handler: #{handler_class_name} (#{e.message})")
  end


  private

  attr_reader :message, :bot

  def command
    @command ||= message.text[COMMAND_REGEX]
  end

  def args
    @args ||= message.text.gsub(command, '').split(',').map(&:strip)
  end

  def handler_class_name
    @handler_class_name ||= "Handlers::#{command.tr('/', '').classify}"
  end
end
