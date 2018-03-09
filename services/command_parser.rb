# frozen_string_literal: true

class CommandParser
  COMMAND_REGEX = %r(\A/([a-z\d_]{,31})(@(\S+))?(\s|$))

  def self.call(text)
    return if text.blank?
    base_part, command, _, mention = text.match(COMMAND_REGEX).to_a

    return if base_part.blank?
    return if mention && ENV['BOT_NAME'] && mention != ENV['BOT_NAME']

    [command, text.gsub(base_part, '').split(',').map(&:strip)]
  end
end
