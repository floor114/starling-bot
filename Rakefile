require 'rake'

require File.expand_path('config/application', __dir__)
require 'standalone_migrations'

Bionic.application.load_files!
Bionic.application.run_initializers!
StandaloneMigrations::Tasks.load_tasks
