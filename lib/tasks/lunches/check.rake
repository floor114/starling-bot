namespace :lunches do
  task check: :environment do
    Telegram::Bot::Client.run(ENV['BOT_TOKEN']) do |bot|
      Lunch.all.find_each do |lunch|
        puts lunch&.chat&.title

        next unless (message = Lunches::Check.call(lunch.members))

        bot.api.send_message(chat_id: lunch.chat.telegram_id, text: message)

      rescue StandardError => e
        puts e
      end
    end
  end
end
