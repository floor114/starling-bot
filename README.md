# Ruby skeleton for Telegram bots

The library provides next features:
* Easy configuration;
* Built-in message parser into command and arguments;
* Internationalization and localization using [i18n](https://github.com/svenfuchs/i18n) gem;
* Handlers for every command;
* Database connection.

## Instalation

First of all, you need to install required gems.

```sh
bundle install
```

Then you need to create `.env` file with your [bot token](https://core.telegram.org/bots#6-botfather).

```sh
echo 'TOKEN=paste_your_token_here' >.env
```

After this, you need to create database config file `config/database.yml`, and fill in your credentials (tip: you can use `erb` syntax).

```sh
cp config/database.example.yml config/database.yml
```

Then you need to create and migrate your database.

```sh
rake db:create 
rake db:migrate
```

After all of this steps you can run a bot.

```sh
bin/run
```


## Customization

For handling new command you need to create new handler called like a command.
For example, if command sent from a user is `/bye`, you need to create handler called `Bye`.
This handler should be inherited from `BaseHandler` and override `answer` method, which is a message that will be sent back.

```ruby
module Handlers
  class Bye < BaseHandler
    private

    def answer
      'Bye!'
    end
  end
end
```

All text after base part (truncated with next regex `/\/[a-z,_]+/`) of command will be split with `,` and passed to a handler as an array called `args`. 

If there is no necessary handler you will see a corresponding message in logs.

## Additional info

More information about bot wrapper you can find [here](https://github.com/atipugin/telegram-bot-ruby).

## Contributing

If you have some proposals how to improve this boilerplate feel free to open issues and send pull requests!

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request
